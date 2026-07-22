# Caching

## Redis

When an external cache is needed, Redis is the recommended choice. For local development, a [Docker image](https://hub.docker.com/_/redis) can be used.

## Hapi.js server-side caching

[Hapi caching](https://hapi.dev/tutorials/caching/) is described in the official documentation. The following guide describes how server-side Redis caching can be added to a Hapi-based service.

Hapi server-side caching uses the [catbox](https://hapi.dev/module/catbox/) interface to abstract away the underlying caching technology being used (e.g. memory, Redis, Memcached).

There are three main concepts to Hapi server-side caching:

* The cache **strategy** (or provider): the underlying caching technology being employed. [catbox-redis](https://github.com/hapijs/catbox-redis) is the Redis adapter for catbox.
* The cache **client**: a low-level cache abstraction, initialised using a cache strategy. Hapi initialises an in-memory cache client by default, and you can create additional cache clients using the same or different strategies.
* The cache **policy**: a higher-level cache abstraction that sets a policy on the storage within the cache (e.g. expiry times). The cache policy also provides additional segmentation within the cache client. Typically the cache policy is how you interact with cache values via the `get` and `set` methods.

### Configuring the default cache client

Hapi initialises an in-memory cache client by default. You can make the default cache client use a different strategy. For example, the following uses Redis or memory depending on configuration:

```javascript
const catbox = config.useRedis ? require('@hapi/catbox-redis') : require('@hapi/catbox-memory')
const catboxOptions = config.useRedis
  ? {
      host: process.env.REDIS_HOSTNAME,
      port: process.env.REDIS_PORT,
      password: process.env.REDIS_PASSWORD,
      partition: process.env.REDIS_PARTITION,
      tls: process.env.NODE_ENV === 'production' ? {} : undefined
    }
  : {}

const server = hapi.server({
  port: config.port,
  cache: [{
    provider: {
      constructor: catbox,
      options: catboxOptions
    }
  }]
})
```

### Configuring additional cache clients

Additional cache clients can be created when initialising the Hapi server by adding new definitions to the `cache` array. Additional caches must be given a `name`. For example, the following creates a new Redis cache client called `session`:

```javascript
const catbox = require('@hapi/catbox-redis')
const catboxOptions = {
  host: process.env.REDIS_HOSTNAME,
  port: process.env.REDIS_PORT,
  password: process.env.REDIS_PASSWORD,
  partition: process.env.REDIS_PARTITION,
  tls: process.env.NODE_ENV === 'production' ? {} : undefined
}

const server = hapi.server({
  port: config.port,
  cache: [{
    name: 'session',
    provider: {
      constructor: catbox,
      options: catboxOptions
    }
  }]
})
```

This example creates two cache clients: the default in-memory cache client and a new cache client called `session` that uses Redis.

Hapi will always use the default in-memory cache client unless you specify the `name` when using it (either directly or via the cache policy).

### Creating and using a cache policy

The cache policy is typically how you interact with the cache. See the [catbox policy documentation](https://hapi.dev/module/catbox/api/?v=11.1.1#policy) for details on how to set and get data.

To create a cache policy using a segment within the default cache client:

```javascript
const myCache = server.cache({
  expiresIn: 36000,
  segment: 'mySegment'
})
```

To create a cache policy using a segment within a named cache client:

```javascript
const myCache = server.cache({
  cache: 'session',
  expiresIn: 36000,
  segment: 'mySegment'
})
```

## Integration with yar session cookies

[Hapi yar](https://hapi.dev/module/yar/) is a plugin that adds unauthenticated session support (state across multiple browser requests) to Hapi. By default it tries to fit session data into a session cookie, but will use server-side storage via the Hapi cache interface if the session data exceeds the maximum cookie size.

Combining Hapi yar with Redis caching allows multiple replicas of a web server to share server-side user session data.

Example configuration using the default cache client:

```javascript
server.register({
  plugin: require('@hapi/yar'),
  options: {
    cache: {
      expiresIn: 36000
    },
    maxCookieSize: 0
  }
})
```

Setting `maxCookieSize` to `0` forces all session data to be stored server-side.

Example configuration using a named cache client:

```javascript
server.register({
  plugin: require('@hapi/yar'),
  options: {
    cache: {
      cache: 'session',
      expiresIn: 36000
    },
    maxCookieSize: 0
  }
})
```

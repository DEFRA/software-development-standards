# Server-Side Caching with Hapi.js

## Redis

When an external cache is needed, Redis is the recommended choice. For local development, a [Docker image](https://hub.docker.com/_/redis) can be used.

## Hapi.js server-side caching

Hapi server-side caching uses the [catbox](https://hapi.dev/module/catbox/) interface to abstract the underlying caching technology (e.g. memory, Redis).

There are three main concepts:

* The cache **strategy** (or provider): the underlying caching technology. [`@hapi/catbox-redis`](https://github.com/hapijs/catbox-redis) is the Redis adapter for catbox.
* The cache **client**: a low-level cache abstraction, initialised using a strategy. Hapi initialises an in-memory cache client by default, and you can create additional cache clients using the same or different strategies.
* The cache **policy**: a higher-level cache abstraction that sets a policy on storage within the cache (e.g. expiry times). The cache policy provides additional segmentation within the cache client. Typically the cache policy is how you interact with cache values via the `get` and `set` methods.

### Configuring the default cache client

Hapi initialises an in-memory cache client by default. You can make the default cache client use a different strategy. For example, the following uses Redis or memory depending on configuration:

```javascript
import Hapi from '@hapi/hapi'
import { Engine as CatboxRedis } from '@hapi/catbox-redis'
import { Engine as CatboxMemory } from '@hapi/catbox-memory'
import config from './config.js'

const CacheEngine = config.useRedis ? CatboxRedis : CatboxMemory
const cacheOptions = config.useRedis
  ? {
      host: config.cache.host,
      port: config.cache.port,
      password: config.cache.password,
      partition: config.cache.partition,
      tls: config.isProd ? {} : undefined
    }
  : {}

const server = Hapi.server({
  port: config.port,
  cache: [{
    provider: {
      constructor: CacheEngine,
      options: cacheOptions
    }
  }]
})
```

### Configuring additional cache clients

Additional cache clients can be created when initialising the Hapi server by adding new definitions to the `cache` array. Additional caches must be given a `name`. For example, the following creates a new Redis cache client called `session`:

```javascript
import Hapi from '@hapi/hapi'
import { Engine as CatboxRedis } from '@hapi/catbox-redis'
import config from './config.js'

const server = Hapi.server({
  port: config.port,
  cache: [{
    name: 'session',
    provider: {
      constructor: CatboxRedis,
      options: {
        host: config.cache.host,
        port: config.cache.port,
        password: config.cache.password,
        partition: config.cache.partition,
        tls: config.isProd ? {} : undefined
      }
    }
  }]
})
```

This example creates two cache clients: the default in-memory cache client and a new cache client called `session` that uses Redis.

Hapi will always use the default in-memory cache client unless you specify the `name` when using it (either directly or via the cache policy).

### Creating and using a cache policy

The cache policy is typically how you interact with the cache. See the [catbox policy documentation](https://hapi.dev/module/catbox/api/) for details on how to set and get data.

To create a cache policy using a segment within the default cache client:

```javascript
const myCache = server.cache({
  expiresIn: config.cache.ttl,
  segment: 'mySegment'
})
```

To create a cache policy using a segment within a named cache client:

```javascript
const myCache = server.cache({
  cache: 'session',
  expiresIn: config.cache.ttl,
  segment: 'mySegment'
})
```

## Integration with yar session cookies

[`@hapi/yar`](https://hapi.dev/module/yar/) is a plugin that adds unauthenticated session support (state across multiple browser requests) to Hapi. By default it tries to fit session data into a session cookie, but will use server-side storage via the Hapi cache interface if the session data exceeds the maximum cookie size.

Combining yar with Redis caching allows multiple replicas of a web server to share server-side user session data.

Example configuration using the default cache client:

```javascript
import Yar from '@hapi/yar'

await server.register({
  plugin: Yar,
  options: {
    maxCookieSize: 0,
    cache: {
      expiresIn: config.cache.ttl
    },
    cookieOptions: {
      password: config.cookie.password,
      isSecure: config.isProd
    }
  }
})
```

Setting `maxCookieSize` to `0` forces all session data to be stored server-side.

Example configuration using a named cache client:

```javascript
import Yar from '@hapi/yar'

await server.register({
  plugin: Yar,
  options: {
    maxCookieSize: 0,
    cache: {
      cache: 'session',
      expiresIn: config.cache.ttl
    },
    cookieOptions: {
      password: config.cookie.password,
      isSecure: config.isProd
    }
  }
})
```

## catbox-redis connection options

`@hapi/catbox-redis` v7 uses [ioredis](https://github.com/redis/ioredis) under the hood. The following options are supported:

| Option | Description |
| --- | --- |
| `host` | Redis server hostname (default: `127.0.0.1`) |
| `port` | Redis server port (default: `6379`) |
| `password` | Authentication password |
| `db` | Database number |
| `partition` | Key prefix for cache segmentation |
| `tls` | TLS configuration object (pass `{}` for default TLS settings) |
| `url` | Redis connection URL (alternative to `host`/`port`) |
| `client` | Pre-configured ioredis instance (must expose a `status` property set to `'ready'`) |
| `sentinels` | Array of `{ host, port }` sentinel addresses |
| `sentinelName` | Sentinel master name (required with `sentinels`) |

Only one connection method should be used: `host`/`port`, `url`, or `client`.

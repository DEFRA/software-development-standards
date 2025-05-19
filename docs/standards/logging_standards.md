# Logging standards

Logging is a critical part of any application. It provides a way to monitor the health of the application, debug issues, and provide an audit trail of what has happened.

## Only log useful information

This will depend on the application, but some common things to log include:

- **Errors**: Capture unexpected issues or failures.
- **Warnings**: Highlight potential problems that may not immediately impact functionality.
- **Informational messages**: Provide insights into the application's normal operations.
- **Debug messages**: Help developers understand the application's behavior during development.
- **Audit logs**: Record user actions or system events for compliance and security purposes.

Logging excessive or redundant information can make logs harder to analyze and increase storage costs.

Consider the logging any third-party libraries do and configure them appropriately.

## Log different levels across environments

Different log levels are useful in different environments. Use the following as a baseline approach and ensure that log levels are easily configurable:

- **Development**: Log debug messages to assist with troubleshooting.
- **Testing/Staging**: Focus on warnings and errors to validate application behavior.
- **Production**: Restrict logs to errors and critical warnings to minimize noise and protect performance.

## Use structured logs

Structured logs are formatted in a way that makes them easy to parse and search. They are typically in a key-value format, where each key represents a piece of information about the log message.

Industry standard structured logging formats should be followed rather than inventing your own.  For example, [Elastic Common Schema (ECS)](https://www.elastic.co/docs/reference/ecs)

```json
{
  "@timestamp": "2025-04-16T12:00:00Z",
  "log.level": "error",
  "message": "Database connection failed",
  "service.name": "user-service",
  "service.environment": "production",
  "event.category": "database",
  "event.action": "connection_failure",
  "host.name": "example-host",
  "process.name": "user-service-process"
}
```

## Do not log any personally identifiable information (PII) or sensitive data

Logging sensitive data can lead to security breaches and compliance violations. Always sanitize logs to remove any sensitive information before storing or transmitting them.

This includes, but is not limited to:

- Names
- Addresses
- Email addresses
- Phone numbers
- National Insurance numbers
- Bank details
- Usernames
- Passwords
- API keys
- Tokens

Be aware of any logging third party libraries may do with this data to avoid any unexpected leaks.

## Logs should be written to a centralised logging system

This allows logs to be aggregated and searched in one place. Examples of centralized logging systems include:

- Elasticsearch, Logstash, and Kibana (ELK stack)
- AWS CloudWatch
- Azure Monitor

## Protective monitoring events should be written to Security Operations Centre (SOC)

Protective monitoring events should be sent to the SOC for analysis and response. 

Teams are expected to engage with the SOC team for guidance on what events should be logged and how to send them.

Examples of events that may need sending to the SOC:

- Authentication attempts
- Access control changes
- Configuration changes
- Network traffic
- Decision making

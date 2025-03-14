# Logging standards

Logging is a critical part of any application. It provides a way to monitor the health of the application, to debug issues and to provide an audit trail of what has happened.

## What to log

When logging, consider what information is useful to log. This will depend on the application, but some common things to log include:
- Errors
- Warnings
- Informational messages
- Debug messages
- Audit logs

## Log levels across environments

Different log levels are useful in different environments. For example, in a development environment you may want to log debug messages to help with debugging, whereas in a production environment you may only want to log errors and warnings.

Consider the log levels that are appropriate for each environment and configure your logging accordingly.

## Use structured logs

Structured logs are logs that are formatted in a way that makes them easy to parse and search. They are typically in a key-value format, where each key represents a piece of information about the log message.

## PII and sensitive data

When logging, it is important to ensure that no personally identifiable information (PII) or sensitive data is logged. This includes, but is not limited to:
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

## Where to log

Logs should be written to a centralised logging system appropriate for your environment. This allows logs to be aggregated and searched in one place.

# Managing dead letter queues

When a service cannot process a message, the broker retries it. Once the delivery attempts are exhausted, the message is moved to a dead letter queue.

The message is not lost, but nothing is going to pick it up again on its own. Someone has to look at it, work out what went wrong, and decide what to do. Left alone, a dead letter queue quietly accumulates failed work that everyone assumes someone else is watching.

Both Amazon SQS and Azure Service Bus provide dead letter queues, and the triage problem is the same on either.

## Triage workflow

1. A message arrives on the dead letter queue after exhausting its delivery attempts
2. Read the message body and its attributes to understand why it failed
3. Decide whether the failure was transient, such as a downstream outage, or caused by the message itself
4. Send the message back to the main queue, correcting the body first if it was malformed
5. Delete the message if it can never succeed

## Things to get right

- **Keep a person in the loop.** Redriving automatically just puts a message that fails deterministically straight back on the dead letter queue.
- **Understand what your broker can tell you.** SQS message counts are approximate and SQS has no true peek, so reading a queue temporarily hides messages from consumers. Service Bus supports exact counts and non-destructive peeking.
- **Watch out for topics.** You cannot publish to a Service Bus subscription, so redriving from a subscription's dead letter queue sends the message to the topic and every subscriber receives a copy.
- **Treat redrive and purge as irreversible.** Ask for explicit confirmation before either.
- **Control and record access.** Restrict who can act on production queues, and log every action with the user who took it so there is an audit trail.

## Example

An example repository has been created to demonstrate how to build a service for triaging dead letter queues using Node.js and Hapi.

It supports both Amazon SQS and Azure Service Bus, and covers viewing queue counts, browsing messages, editing and redriving them, exporting and importing them as JSON, and purging a queue. It runs locally against emulated queues, so you can try the workflow without touching a real environment.

The repository explains the concepts, configuration and operation in full.

[https://github.com/DEFRA/message-hospital](https://github.com/DEFRA/message-hospital)

It uses the pattern described in the [Entra guide](entra.md) to authenticate users and restrict access by role.

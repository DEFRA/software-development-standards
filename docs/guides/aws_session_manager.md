# Session Manager

The purpose of this guide is demonstrate how to use AWS Session Manager to gain access EC2 instances, instead of using SSH.

## Prerequisites

- You will need an AWS account and your user must be part of the relevant developer group/s.
- You must either have access to the AWS console, or have installed the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and [Session Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html). You will then need to [configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html). 

If you need any assistance, don't hesitate to contact the CCoE AWS WebOps team.

## User permissions
When initiating a session, you will be logging into the server as the `developer` user. This user has limited permissions and is intended for basic investigative work only. You won't be able to:

- Run `sudo`, `pm2`, `docker` among other administrative commands.
- Switch to other users.
- Copy files onto or off the server.

If there is anything that you can't do, but that you need to do, please contact the CCoE AWS WebOps team to discuss further. 


## Using the AWS CLI
### Starting a session
Find which instances are available for you to connect to:
```
aws ec2 describe-instances --query "Reservations[*].Instances[*].{Instance:InstanceId,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table
```

Copy the instance ID and then start a session into the instance:
```
aws ssm start-session --target <instance-id>
```

You can find [other examples of starting sessions here](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-sessions-start.html), which includes port forwarding.

If you are having difficulty connecting, please see the [troubleshooting guide here](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-troubleshooting.html). If you're still having issues, please contact <ddts-aws-webops@defra.gov.uk> for support.

### Ending a session
Typically you will be connecting to an Ubuntu server, you can just execute the `exit` command to come out of the session.

However, if your session is stuck, you first need to find your session ID:
```
aws ssm describe-sessions --state Active
```

Copy the session ID and then terminate your session with this:
```
aws ssm terminate-session --session-id <session-id>
```

## Using the AWS Console

1. Login to the [AWS Console](https://aws.amazon.com/console/)
2. Navigate to *EC2 dashboard -> instances*
3. Select a **single** instance that you want to connect to
4. Select *Connect* and then *Session Manager*
    - If you are presented with `We weren't able to connect to your instance`, please contact the CCoE AWS WebOps team.
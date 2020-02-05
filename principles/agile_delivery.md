# Backlog management
All delivery teams must follow an agile delivery approach.  Teams should use whichever agile methodology best fits their delivery, for example Scrum, Kanban etc.

The [GDS Service manual](https://www.gov.uk/service-manual/agile-delivery) provides guidance for agile delivery.  

If teams are unclear which methodology to adopt, they should start with vanilla Scrum and iterate as appropriate.  Teams looking for help getting started with Scrum can follow this [training series](http://scrumtrainingseries.com).

All teams should manage their backlog in a suitable location, for example Jira or Azure DevOps. 

## Issue format
- issues should be appropriately categorised as either an Epic, Story, Task or Bug
- issues should be titled as a problem statement
- issues should include a full description of their purpose
- issues should include acceptance criteria to clearly explain when the issue is done

## New issues
- new issues should be added to the backlog
- if an issue relates to technical debt, a `techdebt` label should be added
- issues should be added outside the current sprint in an estimated priority order

## Backlog refinement
Before an issue can be worked on, it must be refined to include a full description and acceptance criteria.  This must be agreed with the team before it is committed.

## Sizing tickets
Teams may find it beneficial to score tickets to help plan their sprints and calculate delivery estimates.  There are several techniques that could be applied to aide with this including:
- Scrum Poker
- T-shirt sizing
- Large, uncertain, small
- The Bucket system

## Board format
Whether following a Scrum or Kanban approach, teams should have a board to support agile delivery.  A board helps team visualise, prioritise and plan their work.  

As well as a virtual board it would be advantageous to have a physical board mirroring the content.  

The columns within the board should be decided by the team and interated upon if opportunities ot improve delivery are identified.  

The below represents a good starting position for a board.

### Backlog
Issues that need refinement.  Scrum teams may find it better to omit this column and only include issues that are in the current sprint on the board.

### To do 
Refined issues with full description and acceptance critieria.  The team have agreed that these stories are a current priority and are ready to be worked on.

### In progress
Issues currently being worked on.  These issues should be assigned to a team member.  Team members should work on one story at a time where possible to manage Work in Progress (WIP).  Kanban teams may impose a WIP limit to control the throughput of work.

### Review
Issues that have been completed by the team and are ready for review.  The review be undertaken by another member of the team who confirms that all acceptance critieria has been met and the issue is done.  For code based issues, this review is likely to be a [code review](/docs/code-review.md).

It is the responsibility of the person who worked on the task to find a reviewer.  The issue should be reassigned to the reviewer who becomes the new owner.

Teams should not pick up new issues if there are outstanding issues to review to prevent a bottleneck.

### Done
Issues that have been delivered and successfully reviewed.

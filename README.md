# GameJet Transactions

SQL analysis of a mobile game's usage and in-app purchases: how much players use the app, who spends money, and when they first buy.

**Queries:** [sql/queries.sql](sql/queries.sql) · **Full completed document:** [project-pdf/gamejet-transactions.pdf](project-pdf/gamejet-transactions.pdf)

This is a LevelUp milestone project from the Global Career Accelerator program. The scenario and data come from the program. It is not work done for any game company.

## Context

A mobile game earns its revenue from in-app purchases. Before the team plans how to turn more free players into paying ones, it wants a summary of how players use the app and spend money so far.

## Data

- `game_jet.users`: one row per user who installed the game, with install date, language and country.
- `game_jet.sessions`: one row per app session.
- `game_jet.iaps`: one row per in-app purchase, with product type and revenue (in cents).

## Tools and skills

- SQL: `COUNT(DISTINCT ...)`, `GROUP BY` with `HAVING`
- `LEFT JOIN` to keep users with no purchases
- `CASE WHEN` to group players into spending personas
- Common table expressions (`WITH`)
- Date arithmetic with `MIN` to find each user's first purchase

## Approach

1. Counted installed users and users with at least one session.
2. Counted sessions per user and filtered to users above the average.
3. Counted paying users and total spend per user.
4. Grouped players into personas by total spend: free player, minnow, dolphin and whale.
5. Counted users and revenue per persona.
6. Found the days between install and first purchase for each paying user.

## Key findings

- **22,576 users installed the game**, and 32 of them never opened it.
- **The most active user had 1,939 sessions.** Only 5,262 users are above the average of 32.1 sessions, so a minority of heavy users pulls the average up. The median would describe a typical player better.
- **Free players are the largest persona.** Among paying players, whales are the smallest group but bring in the most revenue.
- **724 users made a purchase on the day they installed the game**, which makes onboarding important. Ideas to encourage purchases: incentives during onboarding, offers around holidays, seasonal events or birthdays, and offers after a set number of days of play.

## Running the queries

The queries cannot be re-run outside the program. The data exists only in the Global Career Accelerator SQL app, and this repo does not include it.

`sql/queries.sql` holds the queries exactly as written in the completed document, in order, each labeled with its task. Task 4A keeps a commented-out `HAVING` line as it appears in the document. Task 4B was a written answer.

## Repo structure

```
gamejet-transactions-sql/
├── sql/
│   └── queries.sql                 the queries, labeled by task
└── project-pdf/
    └── gamejet-transactions.pdf    full completed document with written answers
```

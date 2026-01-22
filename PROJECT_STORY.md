# Nudge Fit — Project Story

## Inspiration
I built **Nudge Fit** to solve a personal problem: I already knew *why* I wanted to work out, but I kept losing that motivation at the exact moment I needed it. Planning wasn’t the issue—remembering my reasons was.

So I built an app that acts like a workout butler: it remembers my motivations and gently (sometimes persistently) brings them back until I start my workout or intentionally skip the day.

## What it does
Nudge Fit helps users stay consistent without guilt:

- Choose workout days for the week.
- Define motivations, goals, fitness level, and a preferred coaching tone.
- Receive personalized AI nudges (morning/afternoon/evening) on workout days.
- Tap **Start workout** or **Skip today**—both are deliberate choices.
- Track progress and a streak based on completed workout days.

Instead of generic reminders, nudges are tailored to the user’s own motivations and goals. The app reframes the *same* goal in fresh, human ways so it feels relevant day after day.

## How I built it
**Frontend (Flutter)**
- Flutter handles UI, schedule selection, and day status changes (pending/performed/skipped).
- Local notifications are scheduled on-device using `flutter_local_notifications`, with timezone handling for accuracy.
- A streak card and progress views visualize consistency and weekly momentum.

**Backend (Serverpod)**
- Serverpod stores profiles (motivation, goals, coaching tone, fitness level), week schedules, day schedules, and notifications.
- It generates AI notification copy using **Gemini 2.5 Flash**, anchored to each user’s profile data.
- The server returns tailored notification text while the device schedules delivery locally.

**Data model highlights**
- Weekly schedules include a deadline and a list of day schedules.
- Each workout day gets **three notifications** (morning/afternoon/evening).
- Progress is tracked per week and aggregated into a streak count.

## Challenges I ran into
- **Learning Serverpod quickly.** Coming from Rails and Supabase, the Serverpod mental model took time. Serverpod Academy made it click, especially from a Flutter-first perspective.
- **Designing the data model.** I structured progress around weeks and days, with explicit statuses and notification lists. This kept the logic clear but required careful planning.
- **AI in production UX.** I had to balance prompt quality, latency, token limits, and cost while keeping the experience smooth.
- **Migrating from local-only to Serverpod.** The project started without a backend, so I had to build a translation layer between local models and Serverpod-generated models. Starting server-first would have saved time, but the migration taught me a lot about data ownership and syncing.

## Accomplishments that I’m proud of
- Built a working Flutter + Serverpod app within the hackathon timeline.
- Personalized motivation instead of generic reminders.
- Implemented a scheduling system with streak and progress visualization.
- Integrated a new backend framework and AI messaging end-to-end.
- Delivered an app that fits the “Flutter Butler” theme naturally.

## What I learned
- Serverpod is a strong backend for Flutter once the core mental model clicks.
- Serverpod Academy is a great on-ramp.
- Early data model decisions deeply shape flexibility later.
- AI features require thinking about latency, cost, and UX—not just prompts.
- Personal pain points lead to sharper, more focused product decisions.

## What’s next for Nudge Fit
- True consecutive streak logic (not just total completed days).
- Streak milestones and long-term progress insights.
- Home-screen motivation highlights or quotes.
- Deeper personalization based on user behavior.
- Adjustable coach intensity (from gentle to “very annoying”).

## Built with
- **Dart** + **Flutter** (mobile UI)
- **Serverpod** (backend, data models, APIs)
- **PostgreSQL** (Serverpod database)
- **Gemini API** (AI-generated notification copy)
- **flutter_local_notifications** + **timezone** (on-device scheduling)
- **Riverpod** (state management)

## A tiny bit of math (because the form allows it)
The app already computes a simple weekly coverage ratio:

$$
\text{coverage} = \frac{\text{completed days}}{\text{scheduled days}}
$$

It’s a small thing, but it helps track consistency without guilt.

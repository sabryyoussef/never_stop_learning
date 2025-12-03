# Playwright Beginner Tutorial 6 | Trace Viewer Deep Dive

## 📹 Video Information
- **Title:** Playwright Beginner Tutorial 6 | How to use Trace Viewer
- **Video ID:** Ea4aZB0Zlsw
- **URL:** https://www.youtube.com/watch?v=Ea4aZB0Zlsw
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Playwright Beginner Tutorial 6 | How to use Trace Viewer  
▬ ASK RAGHAV ► https://bit.ly/2CoJGWf  
▬ QUIZ ► https://forms.gle/8vbYLzrneJXjukjVA

---

## ⏰ Timestamps
- **00:00** – Why traces matter for debugging failures
- **01:05** – What Trace Viewer captures (snapshots, timeline, metadata)
- **03:14** – Enabling tracing in `playwright.config.ts` (`trace: 'on-first-retry'`)
- **07:40** – Triggering a controlled test failure to generate trace assets
- **11:50** – Inspecting trace artifacts via HTML report
- **15:56** – Alternate viewing options (CLI, trace.playwright.dev)
- **17:12** – Starting/stopping tracing programmatically inside a test
- **26:30** – Using `beforeAll` and `afterAll` hooks for suite-level tracing
- **33:40** – Navigating action timeline, network, console, and source tabs
- **38:24** – Recap and next steps

---

## 🎯 Key Topics Covered
1. Understanding Playwright trace artifacts and their value in RCA (root cause analysis)
2. Configuring trace capture modes: `on-first-retry`, `retain-on-failure`, `on`, `off`
3. Collecting trace files through retries and failed assertions
4. Viewing traces: CLI (`npx playwright show-trace`), HTML report, hosted viewer
5. Analysing snapshots, action logs, network calls, console output
6. Programmatic tracing using `context.tracing.start/stop`
7. Wrapping tracing in hooks for multi-test scenarios

---

## 💻 Configuration & Code Snippets
### Enable Trace Capture on First Retry
```ts
// playwright.config.ts
export default defineConfig({
  retries: 1,
  use: {
    trace: 'on-first-retry',
    timeout: 10_000,
    expect: { timeout: 3_000 },
  },
});
```

### Generate and View Trace
```bash
# Run a specific spec (expecting failure on first run, trace on retry)
npx playwright test tests/record-demo.spec.js --project=chromium

# Inspect the generated trace
yls test-results/record-demo-chromium/trace.zip
npx playwright show-trace test-results/record-demo-chromium/trace.zip
```

### Programmatic Tracing per Test
```ts
test('trace demo', async ({ page, context }) => {
  await context.tracing.start({ screenshots: true, snapshots: true });
  await page.goto('https://playwright.dev/');
  await context.tracing.stop({ path: 'test-trace.zip' });
});
```

### Suite-Level Tracing with Hooks
```ts
let context: BrowserContext;
let page: Page;

test.beforeAll(async ({ browser }) => {
  context = await browser.newContext();
  await context.tracing.start({ screenshots: true, snapshots: true });
  page = await context.newPage();
});

test('home has Playwright in title', async () => {
  await page.goto('https://playwright.dev/');
  await expect(page).toHaveTitle(/Playwright/);
});

test.afterAll(async () => {
  await context.tracing.stop({ path: 'suite-trace.zip' });
});
```

---

## 🔑 Key Takeaways
- Traces capture every action, DOM snapshot, network request, and console entry—perfect for diagnosing flaky Odoo flows.
- `trace: 'on-first-retry'` + `retries: 1` balances visibility with runtime cost in CI.
- The HTML report links directly to trace files; download them or open via CLI.
- Hosted viewer (https://trace.playwright.dev/) is handy for sharing artifacts without installing Playwright locally.
- Programmatic tracing lets you target critical scenarios; hooks prevent duplication across tests.

---

## 🛠️ Commands Used
```bash
npx playwright test
npx playwright test --project=chromium --trace on
npx playwright show-trace trace.zip
npx playwright show-report
```

---

## 🎓 Odoo-Specific Applications
- Capture traces for intermittent failures in Odoo backend flows (inventory adjustments, PO approvals).
- Inspect RPC payloads and responses to validate server-side business logic.
- Compare DOM snapshots to ensure dynamic views (Kanban, Gantt) render as expected after module upgrades.
- Store `retain-on-failure` traces in CI artifacts to accelerate triage for Odoo regressions.

---

## ✅ Practice Checklist
- [ ] Switch config to `trace: 'retain-on-failure'` and re-run your Odoo smoke suite.
- [ ] Break an Odoo selector intentionally; confirm `trace.zip` is produced on retry.
- [ ] View traces via CLI, HTML report, and hosted viewer; note differences.
- [ ] Add programmatic tracing around a complex Odoo end-to-end flow (e.g., manufacturing order lifecycle).
- [ ] Summarise findings in `phase3_playwright/notes.md`.

---

## 📚 Additional Resources
- Trace Viewer Docs: https://playwright.dev/docs/trace-viewer
- Test Retries: https://playwright.dev/docs/test-retries
- Odoo RPC Reference: https://www.odoo.com/documentation

---

## 🗒️ Full Transcript
```00:00-07:40:lesson06/lesson-06-transcript.md
and today we are going to learn
something very important and very very
interesting in testing in automation
whenever we have any failure whenever
our test fails one of the very important
things is we need to find out and figure
out why exactly this failure happened
what was the error or what exactly
happened at the time of the failure or
what was the screenshot of our
application what was the state of our
application we want to see all the
snapshots and the exact time the
timeline and all the details at that
particular moment when when the failure
happened so that is exactly what we are
going to solve today using Trace viewer
in playwright so we are going to see
what is Chase viewer we will see how to
use test viewer with all the options all
the command line options uh different
ways to view Trace in playwright we will
also learn how to set a tracing
programmatically that is into our code
and then after watching this session you
can take the quiz you will find the link
in the description below this video so
with that let's get started and let us
see what is Trace viewer so Trace viewer
in playwright is a GUI tool that helps
us to uh view our test after it has got
executed we can go back and see how the
test got executed what was the snapshots
the timelines all the screenshots all
the details all the environment details
all the network details and everything
about our test and that is why we call
it as Trace that like we are tracing the
test that has been executed with all the
details now uh here you can see this is
a screenshot of the trace viewer and let
me show you the exact Trace here so you
can see this is the trace viewer this is
a GUI application and here you can see
uh this is one of the tests that I have
bought I have executed and you can see
at the top there is a timeline and as I
go through the timeline you can see the
application screenshot the state of the
application at every point you can see
from here and then you can see all these
steps here so you can see here we went
to the browser here we went to the
application and then you can see the
screenshot of the application the
snapshot you can also see action before
and after state so let me show you on
any click event this will be very
interesting to see let us say this click
on logout button here you can see the
action when you go to the action you can
see exactly where did the action
happened and you can see this red dot
here and then if I say before so it
shows the state of the application
before this action and then after you
can see this was the state after so it
got logged out and we can see the screen
here you can see all the call all the
details console Network and the source
uh where exactly from where exactly uh
this was executed so this is the line
that got executed here so this is
something very very useful very very
important end and in a moment you will
be able to see this case viewer for your
test so let's get started let me stop
this Trace viewer now
and now
let us see how to use Trace viewer and
we will go step by step step number one
is we can open our config file and set
the property and option for Trace now I
will tell you exactly I will tell you
the other options as well how you can do
it from the code itself or how you can
do it from the command but let us start
with the config file so I will go to my
vs code
and
I will go to my project
so this is my project and in your
project you will find this config file
that is playwright.config
so I will go to this config file and
here let us see the trace
option or configuration so here if I
scroll down you can see here is the
trace configuration and it is set on
first retry that means whenever a test
will be retried then it will uh have
this Trace enabled and it will capture
the trace of the test and there are
other options that I will show you there
are options that you can keep it on
permanently so it will keep tracing
every execution you can only trace on
failure or you can trace on the first
three try or you can keep it off
permanently so let us go with this Trace
is on first retry and then uh if I have
to get the trace only on the first retry
I should also have the retries set to at
least one so I will just say
retries
and I will say one
here already there is retry for the CI
environment let me
comment this out I am pressing control
and forward slash on my keyboard to add
a comment here so this is commented out
```

```07:40-16:00:lesson06/lesson-06-transcript.md
and now I have recharized one and the
trace is set to on first retry so now
we have already discussed this will
collect the trace only when retrying for
the first time now let us run our test
and let us run a test to fail so let me
go to any of my tests let us go to uh
this was the test we recorded in the
record demo when we learned how to
record so here we are going to this
source demo.com application and we are
clicking on the username adding the
username and then adding the password
and then clicking on the login button so
let us say I will uh change the selector
for the login button
I will just add here something like one
two three which will make it a invalid
locator invalid selector and now I will
try to run this so this is the name of
this file is
record one hyphen uh demo dot spec
underscore demo.spec all right so let me
run this and we have already set the
configuration make sure that you save
the configuration file and now I will go
to the terminal
you can go from here or just press Ctrl
and J on your keyboard Control Plus J it
will bring up the terminal and here I
will say npx
playwright
test and the test file I want to run is
our record
okay it is I think it has gone to the
test results folder that is not what I
want I want to go to the
tests folder and then from here I want
to run this record one underscore demo
Dot spec.js and if you want you can also
run in a headed mode so that you can see
the execution on the browser so browser
will be in a headed mode that is you
will see the physical browser so it is
running and you can see here it has
entered username and password and now it
will try to click on the login button
but because the selector
it will not find the login button we
have already added our invalid selector
so it should fail
now the other thing is uh let me just
stop this for now
what I want to do is
I'm pressing Ctrl C and
I will stop this for now
okay so what I want to do is because you
can see whenever there is a failure it
is waiting for a long time I can
decrease the time out again I will go to
the config file and this is optional I
am doing this just for this demo so the
timeout is 30 into 1000 here which I
will change to 10 into 1000 which will
be like uh 10 000 milliseconds like 10
seconds and here also I can change this
timeout for expect
to something like 3000 milliseconds that
will be three seconds and now I will run
again
so I will say here I am pressing the top
arrow on my keyboard to go to the last
command and I will just say hyphen
hyphen project
if I want to run on a single browser I
will say project
chromium so it will only run on Chrome
so that we will save some time in the
demo so let's see now
so it has started the test and it will
only run on this browser so you can see
it has added username and password and
now waiting for the login button or
waiting for the object with the selector
that we have which which will fail so
now you can see it is retrying one time
because we have set retry count to one
in our config file so now it is daytime
and now it should also uh get the traces
so it has
completed and now if you see the report
it has already opened the report you can
see this is the initial run the for the
primary run and this is the retry so we
have got the retry as well as the Run
results and here
you can see it has failed here and here
also in the retry it has failed now if
you see in the retry if you go to the
retry execution and you see here you can
see there is a traces here so there is a
section for traces and you can click
here and it will open the trace uh GUI
tool or you can download the trace zip
file from here now before doing that let
me show you
I will go to the next step
which is after running you should check
that chase.zip file is created under the
test results folder so you can go to
your project and there should be a test
results folder now and under the test
results folder you should find a trace
dot zip file and if you
physically go to
this folder on your system I will say
reveal in file explorer you can see this
is the test results and here because we
have executed for a single browser
therefore we have a a trace only for
Chrome otherwise if you had executed on
multiple browsers you will have multiple
Trace files and you can see this is the
trace dot zip now there are different
ways to view this one of the ways is you
can directly go to your result and click
on this traces and you can see this is
our
Trace viewer tool the GUI tool and here
as I have shown you at the top we have
the timeline and you can also see the
steps here so you can see this is the
browser contacts this is this says
go to this page then here it says click
on this locator then here it says
fill this username and you can see the
username is added here now as you can go
in the timeline you can see this
happening
okay and then here you can see the
metadata where you can see the start
time and time duration all the
environment the browser the platform uh
the screen size viewport all these
details you will get and in the actions
you can see all these steps so here it
went to the URL and you can see the
screenshot here then here you can see it
clicked on this
username box and here you can see the
before and after screenshots then here
it fills the data username so you can
see this was the action this was the
before screenshot and in the after
screenshot we have this username added
also if you come here
to the right side
here you can see the call details here
we have all this duration parameters all
the logs
this is the console if you have any
anything in the console you will get it
here and this is the network details so
if you have any details for the network
you can see here in this case there were
so many requests that went to the server
all these API requests you can see you
can see all the details here you can
expand and see all the details and then
in the source you can see the exact code
of our test and it will highlight the
steps that got executed here
```

```16:00-38:24:lesson06/lesson-06-transcript.md
Okay so
you can see here this will now become
very easy to troubleshoot this was our
step and here you can see the action
so the action is
it will click on this login button and
it it has a red dot but it is kind of
invisible because the background also is
red otherwise you will see this red dot
wherever it is clicking so you can see
you see it like this and then you can
see the before and the after and then
you can see all the details so this is
how you can get the trace and now this
was how you can get it from the HTML
report but if you do not have the HTML
report or you don't want to get it from
there you can also directly open the use
the trace.zip file and use the command
npx playwright show hyphen trace and the
location of the trace zip file so let me
show you this I'm going to close this
now and I am also going to stop the stop
serving the HTML report
and now I will say npx playwrite
and I will say
show hyphen Trace
and then the location of the trace file
so our Trace file is under this test
results so I will say test hyphen
results and then we have this
uh this folder and then we have this
Trace dot zip file now see I'm I just
type the first few characters and then I
press Tab and it is auto completing the
name and you should also do this this is
just for beginners so that you do not
make any typo and you can be very fast
in writing these commands so I will hit
enter and let us now see it should bring
up the trace viewer application again
and yes you can see the same Trace
viewer is again here and again you will
see all these details
so this is how you can view the trace
you can create and view the chase now
the other options we have we have
already seen this on first retry it will
record the trace only when retrying only
for the first time then if you want to
keep it off permanently you can keep it
off you can say off in the config file
or or from the command you can keep it
permanently on but make sure if you do
this it will hamper the performance
because it will keep on tracing every
test every step it will keep on taking
all the snapshots screenshots so it can
be uh it can it will be heavy on
performance then retain on failure this
can be a very common option using uh for
using traces because this option will
record a trace it will record for each
test but it will remove from the
successful test run so let's say you
have you have executed all your tests at
the end when you will see you will only
find traces for the failed tests and
that is what we want we want to see what
exactly happened what was the issue only
for the failed tests and you can also
set Trace from the command if you do not
want to set it from the config file you
can set it from the command line and
this is the command
this is our normal command that is npx
playwright test along with this we can
add the option hyphen hyphen trace and
then we can use any of these options on
off on first three try retain on failure
we can use here
okay so this was interesting now let us
say we see different ways to view the
test we have already seen the command
line way we have already seen the HTML
report way that is you can directly see
uh you can view the trace from HTML
report and from the HTML report you can
also download the trace zip file we have
already seen these two options the third
option is using this utility Trace dot
playwright.dev so you can directly go to
this link on your browser
trace.playwright.dev so let me show you
I will go to my browser
and I will go to trace dot playwright uh
dot Dev
uh Chase Dot
playwright.dev
this is the
link and here you can just drag and drop
your Trace zip file or you can also
browse from here so in my case let me go
to the folder where I have my Trace dot
zip file it is here I'm just going to
drag and drop it here
I will drag and drop it here and you can
see we have got our Trace viewer so this
is the third option so these are the
different ways you can view the trace
now how to set trays in the code
programmatically so this is very uh
important so I'll just go here I'll go
to my
project
here
let us say I will go to a different file
let me go to this
example.spec.js this this is the file
everyone will be having because this is
the default example file that comes
along with playwright installation so
I can say
I can add the step here so you can see
we normally add the page fixture we can
also pass the context picture fixture
here which is the browser context and
then using this context we can say
context dot tracing dot start and we can
give the options like snapshots through
screenshots true and then we can have
our test code and wherever we want to
stop we can say context dot tracing dot
stop and we can give the location and
name of the trace zip file so wherever
you want to start you can start the
tracing and wherever you want to stop
you can stop the tracing so let us try
this I am going to this
test file and
I will say here
at the start of the test
let me
make this title of the
test shorter so that you can see this
part as well so here where we are
passing the page fixture I will say
comma and I will also pass the context
fixture and this is the browser context
if you hover over it you can see all the
details for this context
and then
let's say I want to start
at the start before we start our steps
so I will say here await context dot
tracing dot start
await
context dot tracing you should also see
all these order suggestions otherwise
you can press control plus space on your
keyboard to get the auto suggestion box
and I will say start
and then I will give the options so I
will say here so the options we can give
is snapshots screenshots so I will say
snapshots you can see we are getting
these options and I will say true
and then I will say screenshots
and I will say true
okay and if you want to see the
difference if you hover over the
snapshots you can see this will capture
the Dom snapshots on every action so if
you have seen in the trace viewer we
could see the before after action all
these what was exactly the snapshot
before what was exactly the snapshot of
the application after this action all
that is coming from snapshots and in the
screenshots this will capture the
screenshots during tracing now uh this
is the
code and if you like you can put this in
a in the next line for easy readability
so I can do like this
I can put all this in different lines so
that it is very easy to read and you can
also do a right click and say format
document or press shift plus alt plus F
to correct all the formatting and you
can save so this
code this program this command will
start the tracing and then wherever you
want to stop so I want to go to the end
and then here I want to
stop the chasing so again I will say
a weight
and here
in the options I will pass the path
that is where I want to
store the file so let's say I will say
you can give any name so I will say
dot zip or
I can say test one underscore
Trace dot zip and that's it
all right
and that's it so I am uh getting I'm I
want to get trace for this particular
test let us now go to the terminal
I will run it now
so here
I will say npx
make sure that you save the file
and I will say npx
playwrite
test and I want to go to a particular
file so I will give the location of this
example.spec.js
and this time I'm just running it in the
Headless mode with all the browsers so
because there are two tests so it is
running uh this that is fine because it
will overwrite the earlier test file
on Avenue execution that is why it is
showing me this
```

---

*Transcript generated via YouTube MCP on November 7, 2025.*



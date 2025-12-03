# Playwright Beginner Tutorial 5 | How to Record Tests

## 📹 Video Information
- **Title:** Playwright Beginner Tutorial 5 | How To Record Tests
- **Video ID:** -F0eCZK_vxE
- **URL:** https://www.youtube.com/watch?v=-F0eCZK_vxE
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Playwright Beginner Tutorial 5 | How To Record Tests  
▬ ALL FREE COURSES  ► https://automationstepbystep.com/  
▬ ASK RAGHAV  ► https://bit.ly/2CoJGWf  
▬ QUIZ ► https://forms.gle/C9SbsSc9ZJmnrtZt9

---

## ⏰ Timestamps
- **00:00** – Introduction & learning goals
- **01:18** – What is Playwright Codegen (Test Generator)
- **02:14** – Step 1: Launch Codegen (`npx playwright codegen`)
- **03:04** – Step 2: Understanding the two windows (browser + inspector)
- **04:57** – Step 3: Recording steps and generating script
- **06:43** – Step 4: Saving the script and executing it
- **10:40** – Supplying a URL directly to Codegen
- **11:48** – Discovering options with `--help`
- **13:54** – Recording on different browsers (`--browser` flag)
- **15:32** – Saving output to a file (`--target` & `-o`)
- **21:27** – Setting viewport size (`--viewport-size`)
- **22:52** – Emulating devices (`--device`)
- **25:15** – Emulating color schemes (`--color-scheme`)
- **27:26** – Recap and closing reminder

---

## 🎯 Key Topics Covered
1. Overview of Playwright Codegen/test generator workflow
2. Launching Codegen and interacting with the browser + inspector pair
3. Recording login scenarios against demo apps (Sauce Demo)
4. Exporting and saving generated scripts
5. Running recorded scripts in headed/headless modes
6. Advanced Codegen options: custom browser, viewport, devices, color schemes
7. Combining CLI flags and generating Playwright-ready code

---

## 💻 Code Snippets
### Launch Codegen
```bash
npx playwright codegen
```

### Launch with URL
```bash
npx playwright codegen https://www.saucedemo.com/
```

### Launch with Browser and Device Overrides
```bash
npx playwright codegen --browser=firefox --device="iPhone 11"
```

### Save Recorded Script Automatically
```bash
npx playwright codegen \
  --target=javascript \
  --output=tests/record-demo.spec.js \
  https://www.saucedemo.com/
```

### Execute the Saved Test
```bash
npx playwright test tests/record-demo.spec.js --project=chromium --headed
```

---

## 🔑 Key Takeaways
- Playwright Codegen records interactions and produces runnable test scripts instantly.
- Two windows open by default: the target browser and the Playwright Inspector.
- Recorded scripts import `{ test, expect }` and can be customised after export.
- CLI options allow you to specify browser channel, device profile, viewport size, color scheme, and more.
- Use `--output` to save recordings directly into `.spec.ts`/`.spec.js` files.
- Pair recorded flows with the reusable Odoo configuration to accelerate scenario creation.

---

## 🛠️ Commands Used
```bash
npx playwright codegen
npx playwright codegen https://www.saucedemo.com/
npx playwright codegen --browser=firefox
npx playwright codegen --target=javascript -o tests/record-demo.spec.js
npx playwright codegen --viewport-size=1280,720
npx playwright codegen --device="iPhone 11"
npx playwright codegen --color-scheme=dark
npx playwright test tests/record-demo.spec.js --headed
```

---

## 🎓 Odoo-Specific Applications
- Record repetitive Odoo admin flows (install modules, update inventory) to bootstrap tests quickly.
- Emulate tablet or mobile devices when validating Odoo's responsive views.
- Set viewport dimensions that match common Odoo user resolutions (e.g., 1440×900 dashboards).
- Use device emulation when recording POS or mobile warehouse flows in Odoo.
- Adjust color scheme to ensure Odoo custom themes render correctly.

---

## ✅ Practice Checklist
- [ ] Record the Odoo login process and export it to `tests/odoo-login-recorded.spec.ts`.
- [ ] Modify the recorded selectors to use resilient `data-oe-` attributes.
- [ ] Re-run the recorded test in headless and headed modes.
- [ ] Re-record using `--device="iPad Pro 11"` to verify responsive layout.
- [ ] Capture a dark-mode recording for Odoo backend to check theme compliance.

---

## 📚 Additional Resources
- Codegen Documentation: https://playwright.dev/docs/codegen
- Playwright Inspector Guide: https://playwright.dev/docs/debug
- Odoo Playwright Configuration: `~/playwright-configs/odoo-base.config.js`

---

## 🗒️ Full Transcript
```00:00-04:50:lesson05/lesson-05-transcript.md
hello and welcome i'm raghav and today
we are going to learn how we can record
our test in playwright and this is going
to be very easy and very interesting in
the last session we have learned how do
we write our tests and i have shown you
step by step from scratch how do we
create our test in playwright we have a
tool called code gen also called as test
generator and we can use it to record
our test and we can get our playwright
test scripts created automatically so
today we are going to see what is code
gen the test generator tool we will
learn how to record test we will see
while recording test how can we set the
screen resolution or the screen size we
are going to learn how we can record on
a specific browser how we can emulate
devices like iphone or samsung or nexus
how can we emulate emulate these devices
while recording we are also going to see
how can we emulate the color scheme like
or the dark mode or the light mode or
the browser and i will send you a link
you will find a link in the description
below this video for the quiz you can
take the quiz and do let me know your
score after the session and if you have
any questions any doubts you can let me
know your questions in the comments
section below this video so with that
let's get started and let us first see
what is code gen and how do we use the
test generator so playwright by default
comes with a tool called
code gen and it is also called as the
test generator tool and using this code
gen test generator tool we can record
our test and when we start this code gen
we have a command that i will show you
in a moment when we start code gen it
will open two windows
and the first window will be the browser
window where we can go to our web
application and we can interact with our
website and the second window will be
the playwright inspector window this is
the window that gets opened when we try
to debug our tests as well and that i
will show you in a later session how to
debug but for now it will open the
playwright inspector window where we can
see the recorded scripts and then we can
also start or stop recording from there
so
with this let us start step number one
that is we will open the terminal and we
will run the code gen command and the
syntax is npx playwright and we say code
gen now we can also add a url after this
but for now let us
use this simple syntax first npx
playwright code gen so i will go to my
vs code and i have my project open here
and you can create you can open a new
terminal or
in my case the terminal is already open
so i will go to the terminal here
and here i will say
npx
playwright
and
i will say
code gen
and hit enter
and let's see what happens so this
should open two windows the browser
window and the playwright inspector
window and you can see our browser
window is open here and by default it
will open the chrome browser the
chromium
browser but we can also change the
browser that i will show you in a moment
so here is our browser window and if you
see here we also have our playwright
inspector so this is our playwright
inspector window
```

```04:50-10:45:lesson05/lesson-05-transcript.md
now i will split my screen so that i can
show you both the windows
i'm on windows operating system as of
now and to split the screen on windows
operating system you can select one
window and then press the windows key or
the command key on your keyboard and the
left or the right arrow i press the
windows and the left arrow so therefore
this window is now stacked the browser
window is now stacked on the left side
of my screen and then i will select the
window to be stacked at the right side
which is this playwright inspector so i
hope now you can see both these windows
the browser window here and the
playwright inspector window here and i
can also
change the size like this now if you are
on a mac you can do the same thing on
mac as well for example you have two
windows open on mac uh let me say
i have this two windows open on mac here
the way to stack or split the screen
split the windows on mac is you press
this green
icon which is to maximize and you just
hover over it or keep it pressed and you
will get the option to enter
to set the window to the left or right
of the screen or make it full screen i
will say
do this on the left stack this on the
left and this window i will select and
it will get stacked on the
right so
you can do this on mac as well
and this is what i have done on windows
so let me close this here
so now here
i have my browser window and the
playwright window and you will see this
record option this record button is
already enabled that means recording is
in progress so i can start recording i
will
go to some website you can go to any
demo website
and let us say i go to some website like
uh
sourcedemo.com
you can go to any website here is a
website there is a demo website and here
you can see you can give any of these
usernames
this is the password secret sauce
and here now you can see wherever i am
taking my cursor wherever i am taking my
mouse pointer it is
highlighting the objects on the screen
it is finding and highlighting the
objects and
you can see it is also showing us the
selector that it is going to use so in
this case it is going to use this data
test equals username here if i go to the
login button you can see this is what it
is going to use as a selector so you can
see uh beforehand what is the selector
it is going to use now let me enter the
username i can select any of these
usernames so i will say standard user
here i will click in the username box
and you can see the scripts getting
recorded in the playwright inspector i
will say standard underscore
user
and then i will click on the password
box and the password is
secret underscore
source
and then i will click on the login
button so you can see it has logged in
and all these actions are getting
recorded in scripts here so i will just
click on this
and say log out
and that's it i will stop the recording
so i will click on this
record button and it will stop the
recording now you can see some more
options here is a copy button to copy
the script then here is a resume button
a pause button and a step over button
now these three buttons resume pause and
step over will be useful when we do
debugging but as of now we don't need
this so i have stopped the recording and
here if you see this drop down here
```

```10:45-18:10:lesson05/lesson-05-transcript.md
we have options to
export this recorded script in any of
these platforms or languages so we can
export or copy this in playwright test
java javascript python python async pi
test c sharp etcetera but for now i just
want the same playwright so i can
copy from here click on the copy button
or you can manually also copy the steps
by selecting and then i will go back
to my
vs code to my project and under the
test
folder
i will create a new file
rec or
record
one underscore demo dot spec dot js you
can give any name to the file
and i'm just going to paste the recorded
script here so let me
show you i will expand and show you this
i'm pressing control plus b on my
keyboard
so that i will
the sidebar is
hidden and i can show you full screen so
you can see this is the recorded script
it has everything it has also imported
the test and expect
scripts from the playwright package and
here is our starting of the test the
name is test if you want you can give
any name to this test
demo test
and here you can see all the
scripts along with that it has also
added the comments so it says go to this
link then click on click here and here
it is filling the username
then
adding the password
then you can see all these things
that we have recorded and everything is
recorded here so i will press ctrl b
again on my keyboard and now to run this
i can just say i'll go to the terminal
and now
you can see the code gen is still
running to
stop code gen you can either press ctrl
c on the terminal and then say y so i
can say control c and it will say
terminate job i will say y
and it will stop code 10 or you can just
go to the browser where you have
recorded and
close the browser it will stop the code gen
so now to run this i will say
the command is npx
uh it is npx playwright
and because i want to run the specific
file
i will give the location with that is
in the test folder record1 demo.spec.js
now if i run this it will run in a
headless mode i want to run in a headed
mode so i will say hyphen hyphen headed
or let me also say hyphen iphone project
and i will say chromium so that it only
runs on a single browser
we don't want to spend a lot of time in
running in all the browsers and i will
say hyphen hyphen headed all these
commands we have learned in the earlier
sessions so let us now see
it is running our test
and opens the chromium browser and locks
in and locks out so it was quite fast so
it is running fine so this is the
command and uh we can also
add the url of our application right in
the command so that it will start the
browser along with that application open
this is the syntax you can just say npx
playwright codegen or npx playwright
codegen along with your application url
so if i say here
on the terminal if i say
here
npa
code chain
and then i will say i'll give the
url
so now it should open the browser along
with this url open that is google.com
so you can see it has opened the browser
and here is the playwright inspector and
it has already gone to that
website that is google.com so you can
see if i close this browser it will stop
the code gen utility so it has stopped
it here
```

```18:10-27:30:lesson05/lesson-05-transcript.md
so this is how you use it also if you
want to see all the options
all the
commands we can use all the options we
can use with code gen you can say npx
and say hyphen h
or hyphen hyphen
help
and this will show you all the options
we can use with
the code gen tool or the code gen
command so you can see all these options
so here i will show you some of these
some very common options so you can
actually uh send the recorded script to
our output file as of uh now as of the
earlier example we manually copied and
added it to a file but you can use this
i will show you this in a moment uh you
can use the browser by saying hyphen b
or hyphen hyphen browser and select what
browser you want to record on you can
select the channel color scheme the
device emulate the device emulate the
geo location coordinates
you can also do authentication
and proxy
then you can set the time zone you can
set the user agent you can set the
resolution or screen size so all this we
can do with this code gen utility so let
me clear my screen clear the terminal
and let us go to step number two and
we have already seen step number two
when we ran the command npx playwright
code gen it opened two windows browser
and playwright inspector
and we recorded our steps and we also
checked that the
scripts were getting generated
and then
we saw
we saved and ran and checked the
execution so everything was fine we have
seen all these steps if you want you can
take a screenshot of this screen and
keep it handy with you and watch it
multiple times so you will never forget
what is code jan and how to use it
with that
let us see
some different options we can use with
this code gen utility or this code gen
command so if you want to run code gen
on a specific browser or if you want to
record on a specific browser you can say
hyphen b or hyphen hyphen browser and
give the browser name so we have already
seen this
just give me a moment
i think
this is hanged let me just give me one
moment
okay so here i will say npx
and then hyphen b or hyphen hyphen
browser
and i'll say firefox now if you do not
give any browser then by default it
opens chrome but here i'm saying to open
in firefox
and the rest of the things if you want
to give a url along with the along with
the command all that you can do
so you can use multiple options together
so we have our
browser window and our playwright
inspector window here and now i can do
the same thing i can just go to
the website let us say source demo.com
and you can see all this is
getting recorded and i can now use it
and you can see this is the
this is now being
recorded on a firefox browser so you can
do that uh then
the other thing is
you can also save to a file so let us
say we have a file so i'll create a file
i'll create a file under the
test folder
record to
underscore demo dot spec dot gs so this
is our js file
and now i will say npx playwright
codegen
and now i will say
hyphen hyphen target and i will give the
language
so as of now we are using javascript so
i will say target hyphen hyphen target
and i will give javascript here i want
to
export the recorded steps in javascript
and then hyphen o
this is to give the output file and then
the
location of the file so which is
test and here
so i can just say here test
hyphen o
test and record to
demo i will press tab so that it will
auto complete and this is also useful so
that uh i do not make any typos here so
this is what i am doing so now whatever
i will record should directly go here so
let me start the
command
{}
```

```27:30-33:30:lesson05/lesson-05-transcript.md
so we have got our browser here browser
window and this is the playwright window
and i have already shown you how i am
splitting my screen
and opening both of these windows side
by side so i'll just go to the
website sourcedemo.com
i'll enter the username
standard
underscore user
and the password
secret underscore source
and click on login
and then click here
and log out and i will
stop the recording by clicking on this
record button now if you go and check
if i go and check my record to demo you
can see this is
recorded here everything is recorded
here i can just
stop my browser window i can close my
browser window it will stop the code gen
tool as well and you can see everything
is recorded here now here if you
export like this if you record and save
to a file
in this case you may have to add the
test block so it directly starts with
async so let me add the test block here
before async i have to give the
and that's it i think rest of the things
looks fine
i don't need these extra brackets here
this should be fine i can run and check
this
so i will say npx
and i will run this
specific file
record2.demo.spec.js
and let me run in a edit mode and let us
see if it runs fine
so yeah some issue it says const
chromium require playwright i think
this again we have to
change
if i say here
require
here if i start typing playwright or i
think i should say at the rate
playwright you can actually copy this
from any earlier uh
script so normally we say const and we
say
get test and
expect
modules
from
package uh just copy this from any
earlier script
yeah this is what we need
i can either say like this
i can import or say require this we have
seen in very details in the last session
so i hope you know about this
and here also let me just use this
at playwright
let me see if this works out
i'll clear the terminal and run the
command again
and let us see if this runs fine
yes this is running fine
and it is running in a headed mode so it
will run on all the three browsers
chromium firefox and webkit
it is done on chrome it is running on
firefox now and now it is running on
webkit and everything is fine
on webkit i think it is not able to find
the icon where we have log out which is
fine so let it fail that is okay
but yes this is how we can
record and save to a file now you can
also set the viewport or the screen
resolution by saying hyphen hyphen
viewport hyphen size and give the size
so i can say here
let me close this
this is the
report and here it has failed on webkit
we will see this later
for now
i'll go here
stop the report
clear the terminal and i will say npx
and here
viewport so this is viewport size so
hyphen hyphen viewport size
equals 800
by 600
so this is the command and now if i run
this it should open the browser
in this size in this viewport size so
you can see it has opened the playwright
inspector and it has opened the browser
in that particular screen size so you
can also use this viewport size then
we can emulate the devices so if you if
you go to your chrome and if you go to
these three dots and go to more tools
and go to developer tools or you can
just press f12 on your keyboard so it
will go back go to this developer tools
and here you can see these are the
device here is a device icon i can go
i can select the device from here iphone
etc i can select from all this list of
devices any device and then i can do
testing
on
that particular screen which will
emulate that device the same thing we
can do with
playwright and with codegen tool as well
so here i can say hyphen hyphen device
and give the device name so let us
say we have a device
```

---

*Transcript generated via YouTube MCP on November 7, 2025.*

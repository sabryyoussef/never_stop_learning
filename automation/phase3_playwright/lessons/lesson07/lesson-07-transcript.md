# Playwright Beginner Tutorial 7 | Finding Web Elements

## 📹 Video Information
- **Title:** Playwright Beginner Tutorial 7 | How To Find Web Objects
- **Video ID:** wmy1Nu3X8l0
- **URL:** https://www.youtube.com/watch?v=wmy1Nu3X8l0
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Playwright Beginner Tutorial 7 | How To Find Web Objects  
▬ ALL FREE COURSES ► https://automationstepbystep.com/  
▬ QUIZ ► https://forms.gle/HyJrbyQ1hvS9Zopv9

---

## ⏰ Timestamps
- **00:00** – Introduction & goals (selectors vs locators)
- **01:11** – Definitions: selectors, locators, `page.locator()` API
- **05:25** – Demo app setup (`saucedemo.com`)
- **10:25** – Using element attributes (id, name, data-test) with locators
- **15:49** – CSS selector patterns (`#id`, attribute selectors)
- **20:18** – XPath basics for Playwright locators
- **24:55** – Text-based selectors (`text=`, `:has-text()`)
- **28:36** – Recap screenshot
- **31:47** – Leveraging Playwright Inspector to capture locators
- **36:49** – Wrap-up

---

## 🎯 Key Topics Covered
1. Difference between selectors (strings) and locators (Playwright abstraction)
2. `page.locator(selector[, options])` syntax and benefits
3. Building locators from attributes: id, name, data-test, class
4. CSS selector strategies (attribute filters, `#id`, `.class`)
5. XPath support in Playwright (`xpath=` or implicit)
6. Text-based queries and `:has-text()` filters
7. Using Playwright Inspector to generate resilient selectors

---

## 💻 Code Samples
### Attribute-Based Locator
```ts
await page.locator('id=user-name').fill('edison');
await page.locator('[data-test="password"]').fill('secret_sauce');
```

### CSS Selector Examples
```ts
await page.locator('#login-button').click();
await page.locator('form input[type="password"]').fill('einstein');
```

### XPath Locator Variants
```ts
await page.locator("xpath=//input[@name='login-button']").click();
await page.locator("//input[@name='login-button']").click();
```

### Text Queries
```ts
await page.locator('text=LOGIN').click();
await page.locator('button:has-text("LOGIN")').click();
```

### Using Inspector Pause for Locator Discovery
```ts
await page.goto('https://www.saucedemo.com/');
await page.pause(); // opens Playwright Inspector for pick-and-copy
```

---

## 🔑 Key Takeaways
- Start with available stable attributes (`data-test`, `id`) before resorting to XPath.
- `page.locator()` yields auto-wait behaviour (visibility, stability) before executing actions.
- Text selectors are powerful but may match multiple elements—narrow with element type or `:has-text()`.
- Playwright Inspector highlights and copies recommended selectors; use it to avoid brittle locators.
- Combine selectors for complex Odoo widgets (e.g., `.o_main_navbar >> text="Sales"`).

---

## 🛠️ Commands Used
```bash
npx playwright test tests/selectors.spec.js --project=chromium --headed
npx playwright test tests/selectors.spec.js --project=chromium --debug
```

---

## 🎓 Odoo-Specific Applications
- Prefer `data-oe-id` / `data-testid` attributes exposed in Odoo modules when available.
- Use text selectors for menu navigation: `page.locator('.o_app:has-text("Sales")').click()`.
- For list view records, combine CSS with text to target specific rows.
- XPath can help reach legacy fields rendered without unique ids in older Odoo versions.
- Record complex Kanban card locators via Inspector to capture nested structure accurately.

---

## ✅ Practice Checklist
- [ ] Inspect Odoo login inputs and capture selectors via Inspector.
- [ ] Write locators for primary navbar items using text + class combos.
- [ ] Create CSS locators for form fields with dynamic ids using attribute wildcards.
- [ ] Validate each locator with `page.locator(selector).highlight()` (Playwright Inspector).
- [ ] Document chosen locator strategies in `phase3_playwright/notes.md`.

---

## 📚 Additional Resources
- Selectors Guide: https://playwright.dev/docs/selectors
- Locator API: https://playwright.dev/docs/api/class-locator
- Inspector reference: https://playwright.dev/docs/codegen#pick-locators

---

## 🗒️ Full Transcript
```00:00-12:00:lesson07/lesson-07-transcript.md
hello and welcome i am raghav and today
we are going to learn something very
interesting and that is how can we find
objects on the web page how can we find
elements on the web page using
playwright and then we will do action on
those objects or elements now this is
very important in automation whenever we
have to use automation we first have to
find these objects or elements this can
be anything like a text box a button a
radio button a drop down box a title a
image anything on the webpage that you
see is an element or an object and to do
any action on on these objects or
elements we first have to
find or locate these objects and for
that we use selectors and locators and
that is what we are going to learn today
so today we are going to see what are
selectors and locators how to find these
objects with playwright we will see
different selectors like xpath css text
id how to use these and create locators
and then we will also see how you can
automatically generate these locators
using the playwright inspector so this
is going to be very easy and very
interesting and i will show you all the
demos step by step from scratch so let's
get started and let us first see what
are selectors and locators and before we
go into the definition and theoretical
part let me go and show you some
practical i'm on this google home page
so if you just go to google.com you will
see this google home page now here
anything that you see like this search
box this is an object or an element we
call it object or elements in automation
and in general as well this is uh this
button is an object this button is an
object all these links are objects now
let us say i have to
give something or i have to add
something add a text here on this text
box so first i have to find a locator or
find a selector and create a locator for
this box so what i'll do is i'll do a
right click
and
say inspect
this will open the dom or the back end
of this page and you can see here it has
opened this document object model of
this page and here this area is
highlighted this corresponds to this
search box
```

```12:00-36:49:lesson07/lesson-07-transcript.md
now
if you see here you will find there are
a lot of properties this is of type
input it has a class property it has a
name property name equals q type equals
text so it has lot of properties and
using these properties we can create a
locator for this object so i will go
here and i will press ctrl f or command
f if you are on mac and you will get
this
find box here i can create a selector or
i can give a x path i can give a
selector or create a xpath and i can try
to find this
box this uh search box so here let us
say i want to create a x path so i will
give forward slash forward slash and say
input
that means i am creating a relative
xpath and i want to find
objects on this page that
are of type input now if you see here as
i say input you can see it says here one
of nine that means it has found nine
objects on this page having the tag
input or data for our of type input and
if you can see here
if you will keep on
if you click here it will show you all
these objects some of these are hidden
and it will show all these objects and
highlight them but we want this search
box so i will go further and give
these brackets square brackets and i
will say i want to find the input object
that has the name property equals
q because we know there is a name
property and its value is q for our
search box and now you can see it is
saying found one of one that is it has
found a unique object or a unique
element using this x path and now you
can see it is if i
see it is highlighting the search box
and it is also highlighting the area of
the search box on this dom so this is
how we
use automation to find to create
locators and find objects now
today we have so many tools so many
automated tools and applications that
can create these expats for us and in
playwright as well we have options but
before we go to the automated options
let me show you some of the ways so
selectors
in very basic words simple words
selectors are strings or properties of
these web objects and using these
selectors we can create locators so for
example the id
the css
property all these are selectors and
using these we can create locators to
find these objects and all these css
class name id text xpath all these are
selectors and using this we can create
locators now locators
in playwright if i talk about playwright
locator is a class and here the syntax
is we say page dot locator and give any
of these selectors and create a complete
string
do not worry i will show you uh in a
demo how exactly we use this so
just for information locator is a class
in playwright library now let us see how
can we create locators how can we find
objects with playwright so i will go to
my project the playwright project here
and here
i will say uh i will go to the tests
and i'll create a new file first
and i will call this as
you can just select us demo i'll just
say selectors.spec
dot js
```

---

*Transcript generated via YouTube MCP on November 7, 2025.*




# Command Line for Librarians

## [MMWCon](http://mmwcon.org) 2016

+ Presenter [Heather Wilson](https://twitter.com/authcontroller)
    + Acquisitions and Electronic Resources Librarian
    + California Institute of Technology
+ Presenter [R. S. Doiel](https://rsdoiel.github.io)
    + Digital Services Programmer, Caltech Library
    + California Institute of Technology

About: [presentation](index.html)

--

# Why this talk?

## It's all about the metadata

+ Librarians are interested in Metadata
+ Often it is incomplete
+ But there are lots of API exposing metadata through the web
+ Often combining one source with another lets us get a big picture

--

# A big picture

+ The web is more than the web browser
+ The command line is more then a character user interface and repl
+ The web is a conversation, software is a conversation

--

# The web is more than a web browser?

+ the web is webpages
+ the web interlinked data
   + JSON, JSON-LD, XML, GeoJSON, BibTeX, BibFrame, Marc Records ...
+ the web is available on the command line
    + curl, wget, mkpage

--

# What does the command line offer?

+ allows you to explore content in other formats
+ mix and match data and sources
+ it allows you to experiment and automate processes

The command line we're focusing on is the one provided by Bash

--

# What is Bash?

+ Bash is a Unix shell
+ It provides a  way to run programs
+ It can be used interactively to evolve small programs known as "scripts"
+ It is the default shell for many Linux/Unix systems 
    + Standard shell on Ubuntu and Debian Linux
    + Default for Mac OS X Terminal App
+ It is available for Windows 
    + Git Core install, Bash for Ubuntu for Windows

--

# Why do librarians care?

+ Bash lets you automate repetitive tasks easily
    + type a command see if it works
    + scroll back through a command history and cherry pick useful commands
+ The command line no longer lives in isolation from the graphic user interface
    + You can cut and paste commands 

RSD: The last one is a big one. In the old days of green screens cutting and pasting wasn't standardized. Today this isn't really a problem.

--

# Basics of command line

The modern command line includes

+ keyboard navigation
    + arrow keys, delete keys, cut/paste
+ autocomplete (this is really your friend)
    + in Bash tab activates autocomplete
+ command history which you can scroll back through time
    + use *up arrow* for single command scroll back
    + or *history* to see ranges of commands you've run

--

# Still why Bash for librarians?

It's our toolbox. It helps us with &mdash;

+ repition
+ workflows
+ constistancy

--

## Old favorites

+ *curl* is the acme of web data access

## The venerable

They are their when you need them.

+ *cat* and *more*
+ *cut*, *sed* and *grep*
+ your favorite unix text editors

--

# What's in our toolbox?

## There are newer tools too.

+ [git](http://www.git-scm.org) - a distributed version control system
+ [jq](https://github.com/stedolan/jq) is a JSON filter and pretty printer
+ [mkpage](https://caltechlibrary.github.io/mkpage) - easily assemble webpages from simple templates

--

# What's in our toolbox?

## Outside the shell we have

+ Browser plugins like [JSONView](https://jsonview.com/) - a JSON viewer for your web browser
    + supports Firefox and Chrome
+ [OpenRefine](http://openrefine.org/)
+ Even web services like [Github](https://github.com) for collaboration

--

# What was this business about scripting?

Scripts are our path to automation. Think software robots doing our bidding.

## Start with simple robots

+ Scripting is a set of instructions
+ Instructions can be executed by our robot
+ Simple automatation is just a list of commands
    + copy what you need from your history
    + save in a text file 
    + run the file to replay those commands

--

# What was this business about scripting?

## Grow into more complex ones

+ When you get comfortable you can do more complex things
    + make decisions 
        + if this then that else the other thing
    + loops through data (repeat this until...)
    + bundle those decisions and loops together (e.g. functions, procedures)

--

# A couple benefits of scripts.

+ Scripts can be evolved to solve specific problems
+ A script becomes a reference for solving related problems

--

# A User Story 

+ A colleague needs to include a list of publications in a webpage
+ They've dropped by to talk about approaches to building and maintaining that page

--

# What's our problem and our approach?

+ Do some discovery by talking to our colleague
+ Identify systems that may have the information we want 
    + ORCID? CrossRef? OCLC?
+ Query those systems and saving the resulting data 
    + We like data in JSON formats
+ Munging the data if needed
+ Produce a webpage

--

# Our discovery, an ORCID

ORCID Website http://orcid.org

+ Our colleague has an "ORCID id" 
+ ORCID is an unique identifier for authors and researchers
+ Many publications support ORCID (likely require in the future)
+ ORCID has an API
   + https://orcid.org/organizations/integrators/API 

--

# An example ORCID listing

+ Our colleague is Donna 
+ Her ORCID Id: 0000-0003-0248-0813
+ Her profile url will be: http://orcid.org/0000-0003-0248-0813
+ The Works section is the data we want pull for our article list

--

# ORCID API 

The ORCID API gives us another view of that content.

The ORCID API has three types access

+ Public (read) - https://pub.orcid.org
    + The public API has some limitations
    + But it's enough for our purposes
+ Member (read/write) - https://members.orcid.org
+ Sandbox (read/write, for testing) - https://pub.sandbox.orcid.org

See https://orcid.org/organizations/integrators/API

--

# Getting started ORCID

## How do we get started?

To access the API we need a Client ID and Client secret.

For that we need to have our own ORCID id.

+ Once we have our own ORCID we can enable developer access
+ Developer access lets of get a client id and secret (this is what we used to authenticate)

--

# Getting started with ORCID

## Step 1

+ Go to http://orcid.org/register
+ Complete this process creates your ORCID Profile

--

# Getting started with ORCID

## Step 2

+ Go to http://orcid.org/my-orcid and sign in
+ Click on "developer tools" in the upper menu
    + &#8658; https://orcid.org/developer-tools
    + Verify your Email
    + Register your "App"
+ Enable developer tools
    + after that is complete you can "Register for the free ORCID public API"
+ See this http://support.orcid.org/knowledgebase/articles/343182 for details

--

# Getting started with ORCID

##  That was allot of work, why did we do that?

The point of all that was to 

+ Know our "Client ID" (application id)
+ Know our "Client Secret" (application private key)

Go to https://orcid.org/developer-tools and in the middle of the page
You'll find a "show details" tab in the section about your "app". That
has the answers we need for "Client ID" and "Client Secret".

--

# ORCID API

## What data does the API provide?

+ Profile data
    + (ORCID access and control information)
+ Biographical data
    + (e.g. education and other info the ORCID holder volunteered)
+ Works data &#8656; This is what we want 
    + (Publications list)

--

# Getting our data

## Accessing ORCID API with curl

+ save our "Client ID" and "Client Secret" in our environment
+ authenticate and get a "access token"
    + save the auth token in our environment
+ run a curl query 
+ saving the result 

--

# Saving our Client ID/Secret

To save typing and avoid hard coding secrets in our
scripts later we save the client id and secret in our
shell environment (this is destoryed when we exit the shell)

```shell
    export ORCID_CLIENT_ID=APP-NPXKK6HFN6TJ4YYI
    export ORCID_CLIENT_SECRET=060c36f2-cce2-4f74-bde0-a17d8bb30a97
```

+ client id: APP-NPXKK6HFN6TJ4YYI and secret: 060c36f2-cce2-4f74-bde0-a17d8bb30a97
are examples taken from http://members.orcid.org/api/tutorial-retrieve-orcid-id

--

# Authenticating with the API

```shell
    curl -L -H "Accept: application/json" \
         -d "client_id=$ORCID_CLIENT_ID" \
         -d "client_secret=$ORCID_CLIENT_SECRET" \
         -d "scope=/read-public" \
         -d "grant_type=client_credentials" \
         "https://pub.orcid.org/oauth/token"
```

+ This should return a JSON blob with our access token 

```json
    {"access_token":"89f0181c-168b-4d7d-831c-1fdda2d7bbbb",
    "token_type":"bearer","refresh_token":"69e883f6-d84e-4ae6-87f5-ef0044e3e9a7",
    "expires_in":631138518,"scope":"/read-public","orcid":null}
```

+ Notice the URL and how we pass our client id and secret
+ The access token is: 89f0181c-168b-4d7d-831c-1fdda2d7bbbb
    + these change, this is just a sample of what it looks like

--

# Save the access token for re-use

The access token is a really long alphanumeric string with dashes. 

+ copy that to your clipboard and paste into a new environment variable

```shell
    export ORCID_ACCESS_TOKEN=89f0181c-168b-4d7d-831c-1fdda2d7bbbb
```

Now we can start querying the API for data

+ Note: the value of $ORCID_ACCESS_TOKEN is only an example
    + You get a new value from the API each time you authenticate successfully

--

# Using the auth token to access API data

```shell
    curl -L -H "Content-Type: application/json" \
         -H "Authorization: Bearer $ORCID_ACCESS_TOKEN" \
         -X GET "https://pub.orcid.org/v1.2/0000-0003-0248-0813/orcid-works" > example.json
```

+ Note we're using the public ORCID API v1.2
+ ORCID id  we are searching for is 0000-0003-0248-0813 (it's in that middle of the URL in quotes)
+ We're piping the result into *example.json*

--

# Here's the result we saved

+ [Unformated JSON response](unformated-example.txt)
+ [formatted JSON response](formatted-example.txt) with [jq](https://stedolan.github.io/jq)
+ [example.json](example.json) - should pretty print if you have JSONView installed

--

# Creating a webpage with *mkpage*

+ [mkpage](https://githbub.com/caltechlibrary/mkpage/releases/latest) is a single page template engine
+ [A simple HTML template](page.tmpl)

```shell
    mkpage "title=text:Publications List" \
           "name=text:Donna Wrublewski" \
           "orcid=text:0000-0003-0248-0813" \
           "works=example.json" \
           page-pubs.tmpl > wrublewski-pubs-demo.html
```

See [wrublewski-pubs-demo.html](wrublewski-pubs-demo.html).

--

# ORCID API 

## For your reference

+ Setup ORCID API Access if you don't have it already
    + http://members.orcid.org/api/accessing-public-api
    + Tutorials
        + [Retrieving ORCID id](https://members.orcid.org/api/tutorial-retrieve-orcid-id)
        + [Retrieving Public Data](https://members.orcid.org/api/tutorial-retrieve-data-using-public-api)
        + [Using the search API](https://members.orcid.org/api/tutorial-searching-data-using-api)
    + [Code Samples page](http://members.orcid.org/api/code-examples)

--

## Tools used

+ Web browser
+ Bash
+ curl
+ JSONView (browser plugin) and jq (for pretty printing JSON)
+ mkpage (to render the JSON into a web page)

--


# Another Story

Problem:

+ What are the call numbers for Donna's journal titles?

Data Sources:

+ [OCLC](https://oclc.org) - Online Computer Library Center
    + has a public [Classify API](http://classify.oclc.org/classify2/api_docs/)
    + has a explorer page for experimentation-- [OCLC Research Experimental Center](http://classify.oclc.org/classify2/api_docs/classify.html)
    + can be search by "stndnbr" (a standard number), oclc, isbn, issn, upc, ident, heading, owi, author, title and summary
    + API results can provide call numbers

--

# Our Next Story

## Tools needed

+ Bash (initially command line, later we'll create a script)
+ *curl* to fetch our data
+ *jq* to filter results from ORCID
+ *Open Refine* to clean our ata

--
 
# Our Next Story

## *jq* demo

### Creating our initial list of journal titles

*jq* makes it very easy to filter the complex output from the ORCID api into
a simple list of journal titles. This is done by a dot notation path.

```shell
    jq '.["orcid-profile"]["orcid-activities"]["orcid-works"]["orcid-work"][]["journal-title"].value' example.json
```

Initial output

```text
    null
    "Science & Technology Libraries"
    "Abstracts of Papers of the American Chemical Society"
    "Chemical Information for Chemists"
    null
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    "Abstracts of Papers of the American Chemical Society"
    null
```

Piping the output through `grep -v null | sort -u ` cleans up the list easily

```shell
    jq '.["orcid-profile"]["orcid-activities"]["orcid-works"]["orcid-work"][]["journal-title"].value' example.json | grep -v "null" | sort -u
```

--

# Our Next Story

## *jq* demo

### Creating our list of journal titles

```text
    "Abstracts of Papers of the American Chemical Society"
    "Chemical Information for Chemists"
    "Science & Technology Libraries"
```

--

# Our Next Story

## *jq* demo

### What about adding more columns?

After much more experimentation and looking closely at the *jq* [documentation](https://stedolan.github.io/jq) 
you can build up a list of filters that can transform your data. I found it easer to break things
up and pipe through different instances of *jq*. 

```shell
    jq '.["orcid-profile"]["orcid-activities"]["orcid-works"]["orcid-work"][]' example.json |\
      jq '{workType: .["work-type"], journalTitle: .["journal-title"].value, id: .["work-external-identifiers"]["work-external-identifier"][]["work-external-identifier-id"].value, idType: .["work-external-identifiers"]["work-external-identifier"][]["work-external-identifier-type"]}' |\
        jq -r '. | [.workType, .journalTitle, .idType, .id] | join(",")' > example.csv
```

See [example.csv](example.csv)

```text
    JOURNAL_ARTICLE,,DOI,10.5062/F42R3PMS
    JOURNAL_ARTICLE,,EID,10.5062/F42R3PMS
    JOURNAL_ARTICLE,,DOI,2-s2.0-84858766300
    JOURNAL_ARTICLE,,EID,2-s2.0-84858766300
    JOURNAL_ARTICLE,Science & Technology Libraries,DOI,10.1080/0194262x.2015.1135304
    JOURNAL_ARTICLE,Abstracts of Papers of the American Chemical Society,ISSN,0065-7727
    OTHER,Chemical Information for Chemists,DOI,10.1039/9781782620655-00206
    OTHER,Chemical Information for Chemists,ISBN,10.1039/9781782620655-00206
    OTHER,Chemical Information for Chemists,DOI,978-1-84973-551-3
    OTHER,Chemical Information for Chemists,ISBN,978-1-84973-551-3
    JOURNAL_ARTICLE,,DOI,10.5062/F42R3PMS
    JOURNAL_ARTICLE,,EID,10.5062/F42R3PMS
    JOURNAL_ARTICLE,,DOI,2-s2.0-84858766300
    JOURNAL_ARTICLE,,EID,2-s2.0-84858766300
    JOURNAL_ARTICLE,Abstracts of Papers of the American Chemical Society,ISSN,0065-7727
    JOURNAL_ARTICLE,Abstracts of Papers of the American Chemical Society,ISSN,0065-7727
    JOURNAL_ARTICLE,Abstracts of Papers of the American Chemical Society,ISSN,0065-7727
    JOURNAL_ARTICLE,Abstracts of Papers of the American Chemical Society,ISSN,0065-7727
    JOURNAL_ARTICLE,Abstracts of Papers of the American Chemical Society,ISSN,0065-7727
    JOURNAL_ARTICLE,Abstracts of Papers of the American Chemical Society,ISSN,0065-7727
    JOURNAL_ARTICLE,Abstracts of Papers of the American Chemical Society,ISSN,0065-7727
    CONFERENCE_PAPER,,EID,2-s2.0-2442514124
```

This is OK but sometimes it is easier todo this type of transformation in tools like OpenRefine.

--

# Our Next Story

## How do we query OCLC?

1. Go to the [OCLC Research Experimental Center](http://classify.oclc.org/classify2/api_docs/classify.html)
2. Try some values we discovered in [example.csv](example.csv) what combination works
    + E.g. try using ISSN to get OWI, use OWI to get recommended Call Numbers (ddc, lcc)
3. After we figure how we want to query, start trying it out in Bash using cURL.
4. Build up a Bash script that run the querries and accumulate the results

--

# Our Next Story

## Our toolbox

+ Bash
+ curl
+ cut
+ xpath (so we can pluck out specific values from XML)
+ OpenRefine

--

# Our Next Story

Manually getting a call number of "Abstracts of Papers of the American Chemical Society" with ISSN "0065-7727"

```shell
    # Using ISSN to get owi number
    curl http://classify.oclc.org/classify2/Classify?issn=0065-7727&summary=false
    # USe owi to get recommended call number
    curl http://classify.oclc.org/classify2/Classify?owi=15255596&summary=false
```

This is fine if you're a human picking through the XML, but if you have *xpath* then we can pull out the values you
want easily. 

(FIXME: my xpath on my Mac is lacks the common options of -q and -e, rather than pull data directly why not
calc URL save as a column and let OpenRefine do the final fetch and retrieve of the call number recommendations)


```shell
```


--

# Data Cleanup

## Our Final Story

+ Open refine (data cleanup)
    + Remove metadata elements (XML, JSON)
    + Cluster and edit for powerful "nearest neighbor" matching
    + Mass corrections
    + Bulk spreadsheet/CSV files

![alt text](/assets/import.png "Import Options")

--

# Data Cleanup

+ Open Refine Workflow
    + Downloaded raw data
        + Get data from web address
        + Previously fetched data (e.g. ORCID record)
    + Import
        + CSV
        + JSON
    + Versions
        + Raw data
        + Clean file
        + Alternate and templated formats

![alt text](/assets/export.png "Export Functions")

--

--

# The take away

+ The web is more than the web browser
+ The command line is more then a character user interface and repl
+ They are tools in a toolbox for solving problems

Presentation URL 

+ https://caltechlibrary.github.io/command-line-for-librarians/00-presentation.html

Extended version of presentation with more use cases

+ https://caltechlibrary.github.io/command-line-for-librarians/00-presentation-extended.html

Download presentation at 

https://github.com/caltechlibrary/command-line-for-librarians/releases/latest


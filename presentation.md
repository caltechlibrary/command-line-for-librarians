
# Command Line for Librarians

## MMWCon 2016

+ Presenter Heather Wilson
    + Acquisitions and Electronic Resources Librarian
    + California Institute of Technology
+ Presenter R. S. Doiel
    + Digital Services Programmer, Caltech Library
    + California Institute of Technology

About: [presentation](index.html)

--

# This big picture

+ The web is more than the web browser
+ The command line is more then a character user interface and repl
+ The web is a conversation, software is a conversation

--

# the web is more than a web browser

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

--

# What is Bash

+ Bash is a Unix shell
+ It provides a command line interface to programs
+ It can be used to write small programs known as "scripts"
+ It is the default shell for many Linux systems as well as Mac OS X
+ It also is available for Windows 
    + Git Core install, Bash for Ubuntu for Windows

--

# Why care?

+ Bash lets you automate repetitive tasks easily
    + type a command see if it works
    + scroll back through a command history and cherry pick useful commands
+ The command line no longer lives in isolation from the graphic user interface
    + You can generally cut and paste from a graphical app to into the shell
    + You can copy text from the command line and paste into a graphical app


--

# Why this talk?

## It's all about the metadata

+ Librarians are interested in Metadata
+ Often it is incomplete
+ But there are lots of API exposing metadata through the web
+ Often combining it one source with another lets us get a big picture

--

# Basics of command line

The modern command line includes

+ keyboard navigation
    + arrow keys, delete keys, cut/paste
+ autocomplete (this is really your friend)
    + In Bash tab is activates auto complete for some commands and paths
+ command history which you can scroll back through time
    + history 
    + up arrow (for single command scroll back)

--

# What's in the toolbox?

## The old favorites of Unix

+ *curl* is the jackknife for web data access
+ *cat* and *more*
+ *cut*, *sed* and *grep*
+ your favorite unix text editor

--

# What's in the toolbox?

## Some New tools

+ [jq](https://github.com/stedolan/jq) is a JSON filter and pretty printer
+ [mkpage](https://caltechlibrary.github.io/mkpage) - easily assemble webpages from a simple golang template

--

# What's in the toolbox?

## A browser plugin

+ [JSONView](https://jsonview.com/) - a JSON viewer for your web browser
    + supports Firefox and Chrome

--

# Scripting is automation

+ Simple automatation is just a list of commands
    + Copy what you need from your history
    + Save in a text file simple scripts (list of commands)
+ You can also do complex things
    + Decisions 
    + Build functions or use other scripts you've written too

--

# A User Story 

+ A faculty wants to include their publications in a webpage
+ The instution maintains a repository of faculty/researcher's publications
+ They've dropped by to talk about approach and get included in our repository

--

# Problem approach

+ Collect some background info
+ Identify systems that may have the information we want
+ Query those systems and saving the resulting data (preferrable as JSON)
+ Munging the data
+ Import the data into our repository
+ Produce a webpage

--

# Our discovery

+ Our colleague has an "ORCID id"
    + See http://orcid.org
+ ORCID is an unique identifier for authors and researchers
+ Many publications support ORCID (likely require in the future)
+ ORCID has an API
   + https://orcid.org/organizations/integrators/API 

--

# An example ORCID listing

+ Our colleague Donna Wrublewski
+ Her ORCID Id: 0000-0003-0248-0813
+ Her profile url will be: http://orcid.org/0000-0003-0248-0813
+ The Works section is the data we want pull for our article list

(image of webpage)

--

# ORCID API

+ The ORCID API has three types access
    + Public (read) - https://pub.orcid.org
    + Member (read/write) - https://members.orcid.org
    + Sandbox (read/write, for testing) - https://pub.sandbox.orcid.org

--

# ORCID API

+ The public API has some limitations
+ But it's enough for our purposes
    + See https://orcid.org/organizations/integrators/API

--

# ORCID API

## How do we get started?

+ We need to have our own ORCID id
+ Once we have our own ORCID we can enable developer access
+ We can get a client id and secret (this is what we used to authenticate)

--

# Getting started with ORCID

+ Go to http://orcid.org/register
+ Complete this process creates your ORCID Profile

--

# Getting started with ORCID

+ Go to http://orcid.org/my-orcid and sign in
+ Clik on "developer tools" in the upper menu
    + &#8658; https://orcid.org/developer-tools
    + Verify your Email
    + Register your "App"
+ Enable developer tools
    + after that is complete you can "Register for the free ORCID public API"
+ See this http://support.orcid.org/knowledgebase/articles/343182 for details

(see images ORCID1.png - ORCID6.png)

--

# Getting started with ORCID

The point of all that was to 

+ Know our "Client ID" (application id)
+ Know our "Client Secret" (application private key)

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

## Accessing ORCID API with cURL

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

**client id: APP-NPXKK6HFN6TJ4YYI and secret: 060c36f2-cce2-4f74-bde0-a17d8bb30a97
are an example from http://members.orcid.org/api/tutorial-retrieve-orcid-id**

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
    {"access_token":"ACCESS_TOKEN_WOULD_BE_HERE",
    "token_type":"bearer","refresh_token":"A_REFRESH_TOKEN_IS_HERE",
    "expires_in":631138518,"scope":"/read-public","orcid":null}
```

+ Notice the URL and how we pass our client id and secret

--

# Save the access token for re-use

The access token is a really long alphanumeric string with dashes. 

+ copy that to your clipboard and paste into a new environment variable

```shell
    export ORCID_ACCESS_TOKEN=89f0181c-168b-4d7d-831c-1fdda2d7bbbb
```

Now we can start querying the API for data

**access token: 89f0181c-168b-4d7d-831c-1fdda2d7bbbb is an example only, it was from http://members.orcid.org/api/tutorial-retrieve-orcid-id**

--

# Using the auth token to access API data

```shell
    curl -L -H "Content-Type: application/json" \
         -H "Authorization: Bearer $ORCID_ACCESS_TOKEN" \
         -X GET "https://pub.orcid.org/v1.2/0000-0003-0248-0813/orcid-works" > example.json
```

+ Note we're using the public ORCID API v1.2
+ ORCID id is 0000-0003-0248-0813
+ We're piping the result into *example.json*

--

# Here's the result we saved

+ [Unformate JSON response](unformated-example.txt)
+ [example.json](example.json) - should pretty print if you have JSONView installed
+ [formatted JSON response](formatted-example.txt) with [jq](https://stedolan.github.io/jq)

--

# Creating a webpage with *mkpage*

+ [mkpage](https://githbub.com/caltechlibrary/mkpage/releases/latest) is a single page template engine
+ [A simple HTML template](page.tmpl)

```shell
    mkpage "title=text:Publications List" \
           "name=text:Donna Wrublewski" 
           "orcid=text:0000-0003-0248-0813"
           "works=example.json" \
           page-pubs.tmpl > wrublewski-pubs.html
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

+ We have a list of journals titles and ISSN, are they open access journals?
+ What are their call numbers?

Data Sources:

+ [DOAJ](https://doaj.org) - Directory of Open Access Journals
+ [OCLS](https://ocls.org) - Online Computer Library Center
    + has call numbers

--

# DOAJ finding Open Access Journals

+ Problem
    + For  list of journal titles and ISSNs 
        + check if they are listed in DOAJ
        + collect additional metadata about them
+ Requirements
    + Access to the [DOAJ API](https://doaj.org/api/v1/docs)
       + The public read API is sufficient for our needs
+ Steps
    + generate a list of Journal names and identifiers from our bib list
        + [jq](https://stedolan.github.io/jq) is useful for this type of JSON data filtering
    + For each journal query the DOAJ API
    + Save the results

Our output will be a CSV (comma separated value) document.

--

# Tools needed

+ Bash (initially command line, later we'll create a script)
+ *curl* to fetch our data
+ *jq* to filter our results and produce CSV output
+ *Open Refine* to clean our ata

--

# *jq* demo

## Creating our list of journal titles

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
Final list to check

```text
    "Abstracts of Papers of the American Chemical Society"
    "Chemical Information for Chemists"
    "Science & Technology Libraries"
```
--

# More experimentation

After much more experimentation and looking up the *jq* [documentation](https://stedolan.github.io/jq) we came with this
expression to generate a tab delimited file with work type, journal title, id type and id

```
    jq '.["orcid-profile"]["orcid-activities"]["orcid-works"]["orcid-work"][]' example.json |\
      jq '{workType: .["work-type"], journalTitle: .["journal-title"].value, id: .["work-external-identifiers"]["work-external-identifier"][]["work-external-identifier-id"].value, idType: .["work-external-identifiers"]["work-external-identifier"][]["work-external-identifier-type"]}' |\
        jq -r '. | [.workType, .journalTitle, .idType, .id] | join("\t")' > example.tab
```

See [example.tab](example.tab)

```text
    JOURNAL_ARTICLE		DOI	10.5062/F42R3PMS
    JOURNAL_ARTICLE		EID	10.5062/F42R3PMS
    JOURNAL_ARTICLE		DOI	2-s2.0-84858766300
    JOURNAL_ARTICLE		EID	2-s2.0-84858766300
    JOURNAL_ARTICLE	Science & Technology Libraries	DOI	10.1080/0194262x.2015.1135304
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    OTHER	Chemical Information for Chemists	DOI	10.1039/9781782620655-00206
    OTHER	Chemical Information for Chemists	ISBN	10.1039/9781782620655-00206
    OTHER	Chemical Information for Chemists	DOI	978-1-84973-551-3
    OTHER	Chemical Information for Chemists	ISBN	978-1-84973-551-3
    JOURNAL_ARTICLE		DOI	10.5062/F42R3PMS
    JOURNAL_ARTICLE		EID	10.5062/F42R3PMS
    JOURNAL_ARTICLE		DOI	2-s2.0-84858766300
    JOURNAL_ARTICLE		EID	2-s2.0-84858766300
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    JOURNAL_ARTICLE	Abstracts of Papers of the American Chemical Society	ISSN	0065-7727
    CONFERENCE_PAPER		EID	2-s2.0-2442514124
```

This is OK but some of this is easier in other tools (e.g. Open Refine).

--

# Back to our real problem

--

# How do we query DOAJ for Title or ISSN?

1. Go to the [DOAJ](https://doaj.org/api/v1/docs#!/Search/get_api_v1_search_journals_search_query) API playground
2. Review the JSON scheme and see which field you need to query on
3. Try out some queries by hand for individual entries
4. Build up a Bash script that run the querries and accumulate the results
5. Cleanup, depublicate in Open Refine

--

# Discovering our data source

+ [doaj](https://doaj.org/api/v1/docs#!/Search/get_api_v1_search_journals_search_query) provides a sandbox
    + this link provides a playground which generates example *curl* command
    + the field we want to match is `bibjson.title`

Testing the suggested *curl*

```shell
    curl -X GET --header "Accept: application/json" \
        "https://doaj.org/api/v1/search/journals/bibjson.title%3AAbstracts%20of%20Papers of the American Chemical Society
```


--

# Case Study (data source, open web API)

(get the call number of the journals holding the open access articles from OCLC)

Applying the techniques of the open web

## OCLC Public Web API retrieving Call Numbers

+ Problem
    + Processing a CSV file to get additional call number data from OCLC web API
    + Data comes back as XML
+ Lessons learned
    + Leverage environment variables for
        + Authorization key handling

--

# Data Cleanup

+ Open refine (data cleanup)
    + De-dup
    + Cleaning up stats
    + Mass corrections
    + Bulk spreadsheet/CSV files

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

--

# The take away

+ The web is more than the web browser
+ The command line is more then a character user interface and repl
+ They are tools in a tool box for solving problems

--

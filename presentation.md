
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

+ *curl* is the jackknife to access
+ *cat* and *more*
+ *cut*, *sed* and *grep*
+ *xpath* to filter XML

--

# What's in the toolbox?

## Some New tools

+ [jq](https://github.com/stedolan/jq) -
    + *jq* to filter for JSON
+ [mkpage](https://caltechlibrary.github.io/mkpage) - easily assemble webpages from a simple templates
+ [md2slides](https://caltechlibrary.github.io/md2slides) - how this presentation was render
+ [ws](https://caltechlibrary.github.io/ws) - a simple web server for development

--

# Scripting is automation

+ Simple automatation is just a list of commands
    + Copy what you need from your history
    j+ Save in a text file simple scripts (list of commands)
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

+ Our colleague Donna Wrublewski: http://orcid.org/0000-0003-0248-0813
+ Her ORCID Id: 0000-0003-0248-0813
+ The Works section is the data we want pull for our article list

(image of webpage)

--

# ORCID API

+ The ORCID API has three types access
    + Public (read)
    + Member (read/write)
    + Sandbox (read/write, for testing)

--

# ORCID API

+ The public API has some limitations
+ But it's enough for our purposes
    + See https://orcid.org/organizations/integrators/API

--

# ORCID API

## How do we get started?

+ We need to have an ORCID id ourselves
+ Once we have our own ORCID we can get a developer key
+ Once you have the developer key you can access the API

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

+ Goals were
    + Know your "Client ID" (application id)
    + Know your "Client Secret" (application private key)

--

# ORCID API

## What data does the API provide?

+ Profile data
    + About ORCID access and control
+ Biographical data
    + Related data like education the ORCID holder volunteers
+ Works data &#8656; This is what we want for our biblographic list
    + Publications list

--

# ORCID API 

## For your reference

+ Setup ORCID API Access if you don't have it already
    + http://members.orcid.org/api/accessing-public-api
    + Tutorials
        + [Retrieving ORCID id](https://members.orcid.org/api/tutorial-retrieve-orcid-id)
        + [Retrieving Public Data](https://members.orcid.org/api/tutorial-retrieve-data-using-public-api)
        + [Using the search API](https://members.orcid.org/api/tutorial-searching-data-using-api)

--

# Getting our data

## Accessing ORCID API with cURL

+ save our "Client ID" and "Client Secret" in our environment
+ sort out our cURL command with appriate header and URL
+ saving the result

--

# Saving our environment

To save typing and avoid hard coding secrets in our
scripts later we save the client id and secret in our
shell environment (this is destoryed when we exit the shell)

```shell
    export ORCID_CLIENT_ID=YOUR-CLIENT-ID-GOES-HERE
    export ORCID_CLIENT_SECRET=YOUR-CLIENT-SECRET-GOES-HERE
```

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

+ Note the URL and how we pass our client id and secret
+ This should return a JSON blob with our access token 

```json
    {"access_token":"ACCESS_TOKEN_WOULD_BE_HERE","token_type":"bearer","refresh_token":"A_REFRESH_TOKEN_IS_HERE","expires_in":631138518,"scope":"/read-public","orcid":null}
```

See [scripts/api-login.bash](scripts/api-login.bash.txt) for a scripted version

---

# Save the access token for re-use

The access token is a really long alphanumeric string with dashes. 

+ copy that to your clipboard and paste into a new environment variable

```shell
    export ORCID_ACCESS_TOKEN=ORCID-ACCESS-TOKEN-GOES-HERE
```

Now we can start querying the API for data

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
           page-pubs.tmpl \
           > wrublewski-pubs.html
```

See [wrublewsky-pubs.html](wrublewsky-pubs.html).


--
# Case Study (data assembly)

(Check the list of article titles from our colleague and see what is open access)

## DOAJ API finding Open Access Journals

+ Problem
    + Assemble a list of Open Access articles by keyword, by author, by title
    + generate reports, list of links, or indexes for searching
+ Steps
    + Identify the field you are searching on (simple query example)
    + Identify the data path to the field (e.g. bibjson.title.exact)

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

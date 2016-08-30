
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

# Overview

--

# the web is more than a web browser

+ the web is webpages
+ the web interlinked data
+ the web web is available on the command line

--

# What does the command line offer?

+ allows you to explore content in other formats
+ mix and match data and sources
+ it allows you to automate processes

--

# What is Bash

+ Bash is a Unix shell
+ It provides a command line interface to programs
+ It can be used to write small programs known as "scripts"
+ It is the default shell for many Linux systems as well as Mac OS X
+ It also is available for Windows 10 Anniversary Edition

--

# Why do I care?

+ Bash lets you automate repetitive tasks
+ It helps you
+ The command line no longer lives in isolation from the graphic user interface


--

# it's all about the metadata

+ Librarians are interested in Metadata
+ Often it is incomplete
+ but often combining it one source with another lets us get a big picture

--

# Basics of command line

+ keyboard navigation
+ autocomplete is your friend
+ command history and your road to scripts

--

# Old Unix tools

+ *curl* is the jackknife to access
+ *cat* and *more*
+ *cut*, *sed* and *grep*
+ *xpath* to filter XML

--

# Some New tools

+ [jq](https://github.com/stedolan/jq) -
    + *jq* to filter for JSON
+ mkpage - easily assemble webpages from a simple templates
+ md2slides - how this presentation was render
+ ws - a simple web server for development

--

# Scripting is automation

+ putting it together from experiments and history
+ simple scripts (list of commands)
+ complicated scripts (decisions and functions)

--

# Case Study (api keys, mostly open web API)

Get a list and generate a webpage

## ORCID

+ Problem
    + Generate a publication list for colleague's homepage
+ Steps
    + Find the colleagues' ORCID
    + Decide which ORCID end point we want query
        + Look like the Works end point is what we want
    + Fetch the data
        + Know the headers we're going to send
        + Compose the URL to make the query (e.g. parameters and path we're sending)
    + Run cURL

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

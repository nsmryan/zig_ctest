# Zig C Include Test
This repo is simply an attempt to use the Zig programming language to include C definitions
from a header file, and inspect their structure without prior knowledge. In particular,
I would like to be able to iterate through the types in a header without knowing their
names.


This does not appear to work in Zig 0.6.0+0962CC5a3 due to some incompleteness
related to cimport structures.


The use-case here would be to include definitions that describe the structure
of the telemetry of embedded systems and automatically perform things like:
documentation, ingest into a database, montoring, display, etc, directly from
the headers. 

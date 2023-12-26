# System Information (Synfo)
Synfo is a tiny workflow that recovers system information from a node on a given day.
Information it collects:

* CPU usage,
* memory usage,
* reading and writing speeds.

It should be run with a valid [Common Workflow Language](https://www.commonwl.org/) (CWL) implementation.

## Requirements
* `sar` & `sadf` (part of the [sysstat](https://github.com/sysstat/sysstat) package)
* A CWL runner compatible with v1.2 of the CWL specification
* python3 including:
  * pandas

## Usage

The workflow can be run using your favourite CWL implementation.
For example, if using `cwltool` you can run
```
cwltool get_resources.cwl --date XX
```
where `XX` is a date as a two-digit number.
Valid inputs are, e.g., `01`, `09`, `15`, `30`.
The workflow can handle multiple dates simultaneously; each date should be prefixed by its own flag, e.g.:
```
cwltool get_resources.cwl --date 01 --date 02
```
More information can be found by running
```
cwltool get_resources.cwl -h
```

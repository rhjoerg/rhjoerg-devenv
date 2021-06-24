[![Release](https://github.com/rhjoerg/rhjoerg-devenv/actions/workflows/release.yml/badge.svg?branch=main)](https://github.com/rhjoerg/rhjoerg-devenv/actions/workflows/release.yml)

# rhjoerg-devenv
Setup script to install my development environment

## Usage

1. Create a folder which will contain your development environment.
2. Download the [Installation Script](https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/rhjoerg-devenv.ps1) ("the script") into the folder created in 1.
3. Run the script within the folder created in 1.

## Components

Component | Remarks
--- | ---
Directory structure | See below
JDK 11 | LTS Java SDK used to create Google App Engine Applications
JDK 16 | Current Java SDK used for new software
Ant 1.10.10 | Current Ant building tool
Eclipse 2021-06 | Current Eclipse IDE, configured to use JDK-16 and workspace within this development environment

## Directory Structure

Directory | Remarks
--- | ---
&lt;root directory&gt; | The directory you run the script in
&emsp;ant | Ant 1.10.10
&emsp;downloads | Download directory
&emsp;eclipse | Eclipse
&emsp;jdk | Directory for JDKs
&emsp;&emsp;jdk-11 | JDK-11
&emsp;&emsp;jdk-16 | JDK-16
&emsp;workspace | Eclipse workspace

# Eclipse Configuration

The ```eclipse/eclipse.ini``` is replaced with the version available in this project. It sets the Java SDK to use to the JDK-16 installed by the script.

The Ant preferences are set to use the Ant installed by the script.

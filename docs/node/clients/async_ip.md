# OPAL-RT Asynchronous Process (AsyncIP) {#node-client-asyncip}

# Simple OPAL-RT project with AsyncIP    

**Source code:** <http://git.rwth-aachen.de/acs/public/villas/node/tree/master/clients/opal>

# Add AsyncIP to the existing project {#node-client-asyncip-new}

Follow the steps below to add AsyncIP to the existing OPAL-RT project:   

## Step 1

Copy the following files to the _models_ folder of the RT-LAB project:

- Folder: `include/`
- Folder: `src/`
- File: `Makefile.mk`

## Step 2

The `.llm` file should contain the following lines:

```ini
[ExtraPutFilesComp]
include\config.h=Ascii
include\msg.h=Ascii
include\msg_format.h=Ascii
include\socket.h=Ascii
include\utils.h=Ascii
Makefile.mk=Ascii
src\msg.c=Ascii
src\main.c=Ascii
src\socket.c=Ascii
src\utils.c=Ascii
src\compat.c=Ascii
```

## Step 3

In RT-Lab under Files tab, we should see the files listed above for .llm file

## Step 4

In RT-LAB model settings: Development tab -> Compiler -> Compiler Command (makefile) add the following command

```bash
/usr/bin/make -f /usr/opalrt/common/bin/opalmodelmk
```

## Step 5

Maximum number of values in UDP packets:

There is a `#define` inside the implementation which must be changed accordingly.
The #define is in file: `model_directory/include/config.h` There you will find a directive called MAX_VALUES.

It is recommended to keep this value below 300 to ensure that all values are transferred within a single UDP packet. 

# Troubleshooting {#node-client-asyncip-troubleshooting}

## AsyncIP executable still running on target

After the simulation stop `AsyncIP` may still stay alive after the simulation stop. You have to stop it manually because the next simulation start will not be able to start AsyncIP.

Kill running AsyncIP on OPAL:

1. Start Putty.
2. Connect to OPAL-RT target by using the existing profiles.
3. Kill all running processes with name 'AsyncIP' by running `$ killall AsyncIP`.
4. Logout from the OPAL-RT target by running `$ exit`.

**See also:**
 - [OPAL-RT KB Article AA-00737](http://www.opal-rt.com/KMP/index.php?/article/AA-00737/10/Problem-Solution/RT-LAB-10%3A-AsyncSerial-process-is-not-properly-cleaned-after-model-reset.html)
 - [OPAL-RT KB Article AA-00770](http://www.opal-rt.com/KMP/index.php?/article/AA-00770/10/Problem-Solution/Model-doesnt-reset-properly-when-having-multiple-OpIPSocketCtrl-for-Async-IP-communication.html)

## Problem occurs when there are multiple subsystems (SM_, SS_, ...)

Even there is no `OpAsyncIPCtrl` in every subsystem, RT-Lab wants to build a AsyncIP executable during building process, if there is no OpAsyncIPCtrl it shows error.

Workaround for now: place fake OpAsyncIPCtrl in each subsystem.

Additional problem: After Load, only AsyncIP in master subsystem (`sm_`) is started.

Actually: this helps that you do not need fake blocks:

.llm file should contain the following:

```ini
[ExtraPutFilesComp]
C:\OPAL-RT\RT-LAB\v10.7.7.506\common\lib\redhawk\libOpalAsyncApiCore.a=Binary
```

**Note:** The path of `libOpalAsyncApiCore.a` depends on your version of RT-LAB.

but it seems that still you can you it only in SM_...

**See also:** [OPAL-RT KB Article AA-00491](http://www.opal-rt.com/KMP/index.php?/article/AA-00491/9/QA/ARINC-and-AsyncSerial-processes-in-complex-models.html)

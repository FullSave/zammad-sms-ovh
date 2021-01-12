# zammad-sms-ovh

Zammad package for sending SMS with OVH provider.

## Building

Launch the `build` script to generate a szpm files from the source files.

```shell
./build
```

This requires to have Ruby installed on your system.

You may want to update the script if you need to update the package metadata or its content.

## How to use

After building the package, head over to your Zammad Dashboard.
There, go to Settings -> Packages. Upload the `ovh-sms.szpm` file to add the package.
Then, go the SMS settings and add OVH as a new provider for notification. (receiving SMS is NOT supported)

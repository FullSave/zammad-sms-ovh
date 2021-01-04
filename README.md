# zammad-sms-ovh

Zammad package for sending SMS with OVH provider.

## How to use

In your Zammad dashboard, go to Settings -> Packages. Upload the `ovh-sms.szpm` file to add the package.
Then, go the SMS settings and add OVH as a new provider for notification. (receiving SMS is NOT supported)

The `ovh.rb` file is present in the repository for reference, but its content is actually embedded into the szpm file as a Base64 string.

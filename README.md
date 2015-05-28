Documentation for the file server

MODELS

Files are represented by the FsFile class
They're identified by "file_id" and "site_id" (currently not forced to be unique, but they should be because I assume that files are uniquely identified this way)
Also have "file_data_file_name", "file_data_content_type", "file_data_file_size", "file_data_updated_at", "created_at", "updated_at", and "filepath" which are hopefully self explanatory fields.
"filepath" is an absolute path.
"client_key" is used to make one-time downloads of files; client key set means file can be downloaded, and with the download, the client_key is reset to nil i.e. trying to download again won't work.

AdminUser and ClientUser are subclasses stored in the same "users" table. Perhaps the names are misleading because they really have nothing to do with users; they're just used to generate and validate keys. 
No way to create an AdminUser without going to console (just commented out the route in config/routes.rb, the function still exists)
Creating a ClientUser requires a valid admin key (which comes from an AdminUser). 

CONTROLLERS AND CONTROL FLOW
Uploading a file requires an admin key, and a hash called file_params with file_id, site_id, and actual file. It might not work right now because the download tests are failing from "got: nil" errors.

Downloading a file requires an admin key and a hash called file_params with file_id and site_id. If the admin key is valid, it'll return json with a link. Going to that link will download the requested file and reset the client_key field for that file. Going to the link a second time won't work. (Race condition I just thought of, I guess if two people try to download the same file, only the first person to actually go to the download link will be able to get it. The second person will get a fail on their first try. Maybe need to make that a list/queue of client keys?)

fs_file_controller has most of the important things, application_controller probably wins second place because I wanted functions available to both fs_file_controller and user_controller. user_controller is essentially just the create_client function, which really should be called create_client_key or something. 

KNOWN ISSUES
Failing tests! Sorry :3 Not sure what's up with uploading... but two tests in fs_file_controller_spec are failing probably because I'm not uploading correctly. It seems to work manually though.
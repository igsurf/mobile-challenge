# Core Archtecture
As the CoreInterfaces provede protocols that allow communication between layers, CoreArchtecture provide the implementation of some protocols of interrest, creating and providing some features for application consume.  

## Domain 
The domain layer provides implementations to be used for application layer. This layer is the bridge beetween Application and Infrastructure layers. Domain communitate with Infrastructure layer by Adapters

###  Providers
Providers are like factories to create Service Workers since the application cannot create or access any worker.
The workers cannot be accessed outside the framework and the application just know about ports, that are protocols that describes the services privided by framework. The provider obfuscate the creation of workers hiding all details from application and delivery only an opaque object under a protocol signature.
Providers is the only way that the application access Domain objects inside framework, but de details of this objects remains unknown to the application layer.

### Services - Workers
Works are internal implementations under InputPorts protocols provided by CoreInterfaces. The workers implementation is totally opaque to the application that only can get a worker via provider.

## Intrastructure 
Implements and provides ways for domain layer to access external resources, like network, database, files, etc. Only domain layer can access this layer. 
In a improved version the Domain and Infrastructure should be separated in differents frameworks.

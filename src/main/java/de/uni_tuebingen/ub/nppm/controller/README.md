Suggesttion to Refactor -> MVC Functionality:

    Use Spring MVC:
        Create for each Entity a controller
        Create for each page in neg a controller function
        
Description of the Example:
    - In the example a controller function for the Entity Edition is defined

    - The controller is in the package de.uni_tuebingen.ub.nppm.controller

    - The URL to call the function is http://localhost:8080/neg/edition/list

    - The view is in WEB-INF/views/list-edition

    - The spring configuration is in WEB_INF/spring.xml

    - The Servlet Descriptor is in WEB_INF/web.xml
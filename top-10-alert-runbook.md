# Top 10 mnage alert and how to resolve


* [ ] 1.0 Slow database connectivity reported for mas manage

     MAS Manage uses database for storing asset related data. Good connectivity between MAS Manage and the database server are required for better user experience. Check the network connectivity between openshift node running the MAS Manage and Database server.

     ![image](https://github.com/user-attachments/assets/e32c3d93-e0ab-4928-ae36-c1291dcfe266)
     
     a. Network Connectivity
     Log into ocp worker node running the MAS Manage pods
     ```
     dig <db server>
     check for query time < 30 msec
     ```

     b. Check, if the DB server is up and accessible

  3. 

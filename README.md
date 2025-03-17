# HarborManager
## Authors: Adam Bednarek, Miłosz Sobol
!!!**This is an export from my Oracle Apex workspace!!! WRITTEN IN PL**

Since I've lost the workspace, I cannot guarantee that it's going to work/be complete after importing the project. <ins>Just in case, I've also included a DB SQL script which can be used seperately, with the app excluded.</ins>

## Description

*HarborManager* is a database application designed in **Oracle Apex**. The database was writted in **Oracle PL/SQL**. The website also includes a few custom **CSS** and **JavaScript** features.

- The application is designed to manage port operations, particularly ship routes, by assigning resources such as ships cargo and working crew. <ins>Please keep in mind that it's general goal is to create a tycoon-game-like experience; it's meant to serve as a (limited) simulation.</ins>

- It allows performing CRUD operations on each table record.
  
- *HarborManager* features simple statistics for main subpages. 

- The port employs crewmembers, each belonging to a specific crew (only once per such) and assigned a role. Employees can be managed, meaning they can be added or removed, or assigned as a whole team to specific ships/courses.
  
- The port operates a fleet of cargo ships. A ship can be sent on a route to any accessible port, provided it is not currently engaged in another task and has enough resources, such as budget, fuel (capacity, fuel burning) and available crews with a captain.
  
- When dispatching a ship on a route, it is possible to assign a shipping manifest to it. The listed objects (containers and passengers) must be delivered by the ship as part of the route. You can compose your own shipping manifests based on available resources.
  
- Fuel is automatically bought before each dispatch, unless there is no budget. You can always check on your balance and fuel stock on a dedicated subpage. Here you can also add money to your budget (yes - it's a god mode, there is no implementation of earning money from finishing courses) and make seperate fuel purchases.

- The app is also secured with constraints/triggers such as “A ship cannot be dispatched/an employee cannot be assigned – currently engaged in another task” etc. WARNING: IT'S NOT BULLETPROOF, but they prevent from making many trivial mistakes.
  
For any doubts - here are both logical and physical **database** models:
![155963_155905_HARBORMANAGER_DIAGRAM_NIEBIESKI](https://github.com/user-attachments/assets/02c23189-dab8-4e93-afb2-47877bc889b7)
![155963_155905_HARBORMANAGER_DIAGRAM_ZOLTY](https://github.com/user-attachments/assets/e1fbb96f-131b-45c9-846a-30aa37210236)


# RBXLX-TO-ROJO

I made this project as a quick, quirky workaround to port already existing Roblox games to Rojo projects. The short story is the currently existing converters such as [this guy](https://github.com/rojo-rbx/rbxlx-to-rojo) don't do a very good job at grabbing the scripts I need and giving me really weird results. At least, not for me. This is a hacky project built in ~20 minutes, so don't be too judgemental about the code or process involved.

# Prerequisites

### Node.js (version 18 or higher)

I opted to use a small local Node server to receive script data from Roblox Studio. Like I said, quirky workaround.\
Download Node.js here: https://nodejs.org/

### Roblox Studio (latest version)

You will need Roblox Studio installed with access to the place file you want to export.\
Download Roblox Studio here: https://create.roblox.com/

# Using the Software

### Start the script saver server

Open a terminal in the project directory you have saved the repository to. Run "node saveServer.js" (without quotes). You should see: "Listening on http://localhost:8080/save"

### Enable HTTP Requests in Studio

The exporter uses `HttpService:PostAsync`, which requires the following setting:

-   In Roblox Studio, click **File**
-   Open **Game Settings**
-   Go to **Security**
-   Enable **Allow HTTP Requests**

**⚠️ THIS IS REQUIRED. PLEASE DO NOT FORGET TO TURN OFF ALLOW HTTP REQUESTS ONCE YOU ARE DONE PORTING ⚠️**

### An `.rbxl` or `.rbxlx` file of your game

Save your game as an `.rbxlx` file (if you want to know the technical reason, it's because Roblox stores instance data in a more readable format in .rbxlx files). To do this, simply:

-   **Open your world** in Roblox Studio
-   Hit **File**
-   Click **Save to file as** (CTRL + SHIFT + S)
-   Change the "Save as type" drop-down to **Roblox XML Place Files (\*.rbxlx)**
-   Press **Save**

### Command Bar enabled in Studio

You must run the exporter through the Studio Command Bar.
You can enable it by opening the **View** tab and enabling **Command Bar**.

### Running the export

-   Open `CommandBar.lua` and **COPY** the code to your clipboard.
-   Paste the code into the Command Bar in Roblox Studio.
-   Hit enter and wait for the process to complete.
-   DONE
-   You may now kill the server.
-   **_Don't forget to TURN OFF ALLOW HTTP REQUESTS_**

You can now find the results in your "exported" folder in the **SAME** folder you ran "node saveServer.js" from. In other words, check the **_server_** folder, **NOT** the folder with the .rxblx file! If you placed them both in the same folder, you will find it there.

# Troubleshooting

There are no known errors when running this software. If you encounter an issue, please submit an issue report with as many details as possible. This software was only tested on Windows, but should work out of the box on Linux.

# Contributing

Contributors are always welcomed, but please make sure your changes are useful in some way, and properly update the software version.

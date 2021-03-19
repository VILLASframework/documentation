# VillasWeb branding
## Existing brands
VillasWeb - 'classic branding'
SLEW - Second Life for Energiewende, RWTH education project

## How to create a new brand
1. create a new folder for the new brand
2. add files inside your brand folder
    - 'functions' (HTML-code for welcome page, home page, app footer)
    - 'values' file definitions
```
const <brand_values> = {
   title: '<brand title>',
   subtitle: '<brand subtitle>',
   icon: "<brand icon, !needs to be in public folder with favicon!",
   pages: {
      home: <true|false>,
      scenarios: <true|false>,
      infrastructure: <true|false>,
      users: <true|false>,
      account: <true|false>,
      api: <true|false>
   },
   links: {
      "<link description>": "<link>",
      "<link description>": "<link>"
   },
   style: {
      background: '<background color>',
      highlights: '<color for highlights like title and table>',
      maincolor: '<main color for texts and symbols',
      primarytext: '<primary text color, e.g. for home page>',
      secondarytext: '<text color for menu and footer',
      font: "<text font, e.g. 16px Roboto, sans-serif>",
      borderradius: "<0px for sharp box edges, >0px for rounded box edges>"
   }
}

export default <brand_values>;
```

colors can be defined in several ways (CSS syntax), examples:
```
#ff000
red
rgb(255,0,0)
rgba(255,0,0,0.7)
```

3. adapt branding.js:
    - import 'values' and 'functions' files
    - if applicable, add case in switch statement for the following functions:
        - setValues
        - getHome
        - getWelcome
        - getFooter

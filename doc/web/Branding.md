# VillasWeb branding
## Existing brands
* VillasWeb - classic branding
* SLEW - Second Life for Energiewende, RWTH education project
* template - can be used for new brand creation

## How to create a new brand
1. create a new folder for the new brand inside the `branding` folder - !needs to be written in the same way as the branding environment variable `REACT_APP_BRAND=<brandname>`!
2. add files inside the folder of your brand 
    - `functions` (HTML-code for welcome page, home page, app footer)
    - `values` file definitions
```
export function <brand_home>() {
    return (
        <div>
            <h1>Home</h1>
            <p>
                Welcome to <b>BRAND</b>!
            </p>
            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut 
            labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. 
            Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>
            
            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore 
            et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. 
            Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

        </div>)
}

export function <brand_welcome>() {
  return (
      <div >
          <h1>Welcome!</h1>
          <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ...</p>
      </div>)
}
```
    
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
    - if applicable, add cases in switch statements for the following functions:
        - setValues
        - getHome
        - getWelcome
        - getFooter

# Branding

## Existing brands

* VILLASweb - Classic branding
* SLEW - Second Life for Energiewende, RWTH education project
* template - Can be used for new brand creation

## How to create a new brand

1. Create a new folder for the new brand inside the `branding` folder. The folder name must match the branding environment variable: `REACT_APP_BRAND=<brandname>`!
2. Add the following files to your brand's folder:
    * `functions` (HTML code for the welcome page, home page, and app footer)
    * `values` file for definitions

```js
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

```js
const <brand_values> = {
   title: '<brand title>',
   subtitle: '<brand subtitle>',
   icon: "<brand icon, (must be in the public folder with the favicon)!",
   pages: {
      home: <true | false>,
      scenarios: <true | false>,
      infrastructure: <true | false>,
      users: <true | false>,
      account: <true | false>,
      api: <true | false>
   },
   links: {
      "<link description>": "<link URL>",
      "<link description>": "<link URL>"
   },
   style: {
      background: '<background color>',
      highlights: '<highlight color for titles and tables>',
      maincolor: '<main color for text and symbols',
      secondarytext: '<text color for the menu and footer',
      font: "<text font (e.g., '16px Roboto, sans-serif')>",
      borderradius: "<'0px' for sharp box edges, '>0px' for rounded box edges>"
   }
}

export default <brand_values>;
```

Colors can be defined in several ways (CSS syntax), for example:

- `#ff0000`
- `red`
- `rgb(255,0,0)`
- `rgba(255,0,0,0.7)`

3. Adapt `branding.js`:
    - Import the `values` and `functions` files.
    - If applicable, add cases to the `switch` statements for the following functions:
        - setValues
        - getHome
        - getWelcome
        - getFooter

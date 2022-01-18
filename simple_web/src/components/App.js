// import React from 'react';

// function App() {
//   return (
//     <div className="App">
//       <ClickMe />
//     </div>
//   );
// }

// export default App;

// origin link https://github.com/aditya-sridhar/simple-reactjs-app

import React, { Component } from 'react';
import './App.css';
import ClickMe from './ClickMe';
import { BrowserRouter as Router, Switch, Route, Redirect} from 'react-router-dom';


class App extends Component {
  
  sayIP() {
    var hostname = window.location.hostname
    var port = window.location.port
    const msg=`Base URL: ${hostname}:${port}`
    return msg
  }

  render() {
    console.log("Host URL: "+process.env.PUBLIC_URL);
    return (
      <Router basename={process.env.PUBLIC_URL}>
        <div className="App">
          <header className="App-header">
            <h1 className="App-title">Simple React App </h1>
            <h2 className="App-text">{<div>{this.sayIP()}</div>} </h2>

          </header>
        </div>
        <div className="ClickMe">
          <ClickMe />
        </div>
    </Router>
    );
  }
}

export default App;
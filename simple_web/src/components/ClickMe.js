import React from 'react';
import "./ClickMe.css"
const ClickMe = () => {
  
  function sayIP() {
    var hostname = window.location.hostname
    var port = window.location.port
    const msg=`Base URL: ${hostname}:${port}`
    alert(msg);
  }
  
  return (
    <button onClick={sayIP}>Click Me!</button>
  );
};

export default ClickMe;
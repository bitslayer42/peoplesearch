// No IE 11, use polyfill: https://www.npmjs.com/package/web-animations-js
var elem = document.querySelector('.animate-me');
elem.animate([
  { 
    transform: 'translateY(-1000px) scaleY(2.5) scaleX(.2)', 
    transformOrigin: '50% 0', 
    filter: 'blur(40px)', 
    opacity: 0 
  },
  { 
    transform: 'translateY(0) scaleY(1) scaleX(1)',
    transformOrigin: '50% 50%',
    filter: 'blur(0)',
    opacity: 1 
  }
], 1000);
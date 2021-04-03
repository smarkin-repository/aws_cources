# Цель Курса

Обучиться создание Full-stack приложению для работы с проектами и данными для VR Concept

Основные части

- server
    isomprh:
        https://github.com/nickbalestra/sankey
        https://github.com/Olical/react-faux-dom
        https://github.com/DevAlien/dripr-ui 
        https://github.com/DavidWells/isomorphic-react-example
        https://github.com/GoogleChromeLabs/sw-precache/tree/master/app-shell-demo
        https://github.com/danielstern/isomorphic-react
        https://github.com/wahengchang/react-redux-boilerplate
        https://hackernoon.com/react-redux-isomorphic-boilerplate-best-practice-example-tutorial-learning-rendering-reducer-action-8a448d0dbddb
        https://medium.com/devschacht/peter-chang-break-down-isomorphic-and-universal-boilerplate-react-redux-server-rendering-8fd0ec4a8512
        https://habr.com/ru/post/473210/
        
        [] официальный документ https://redux.js.org/recipes/server-rendering

       []   разобрать пример   
            https://www.freecodecamp.org/news/server-side-rendering-your-react-app-in-three-simple-steps-7a82b95db82e/ https://github.com/Rohitkrops/ssr
        
       []   пройти курс - примера уровня 2016 года
            https://habr.com/ru/post/309958/
            https://habr.com/ru/post/310284/
            https://habr.com/ru/post/310952/
        nginx:
            https://gist.github.com/tomasevich/a2fe588c451c5a192893e6521a813020
            https://www.sitepoint.com/configuring-nginx-ssl-node-js/
        tools: 
            https://react-server.io/
- client
    react redux
    https://habr.com/ru/post/498860/
    React cource
    https://habr.com/ru/company/ruvds/blog/432636/
    Animation
    https://habr.com/ru/company/skillbox/blog/456972/
    Example project:
    https://habr.com/ru/post/308100/
    https://habr.com/ru/post/350946/
    https://habr.com/ru/post/350298/
- database
- authorisation
  https://habr.com/ru/post/340146/
  https://habr.com/ru/post/504344/
  https://habr.com/ru/post/485764/
- infra Azure
- infra AWS
- CI/CD
- 3d WebGL:
https://morioh.com/p/c0abf43e5d59
https://github.com/tim-soft/react-particles-webgl
https://www.sitepoint.com/building-a-game-reactjs-and-webgl/
https://hackernoon.com/react-webgl-different-ways-of-creating-3d-apps-with-react-3af844f61257
https://medium.com/@summerdeehan/a-beginners-guide-to-using-three-js-react-and-webgl-to-build-a-3d-application-with-interaction-5d7b2c7ca89a
https://medium.com/better-programming/react-three-fiber-build-3d-for-the-web-with-react-and-webgl-easily-c0df8801292
https://www.programmersought.com/article/8382628405/
https://developer.aliyun.com/mirror/npm/package/react-3d-viewer
https://facebook.github.io/react-360/docs/objects.html
https://medium.com/@zakhuber/loading-3d-models-into-react-with-webgl-and-three-js-273a492e645f
https://github.com/haafoo/react-3d-model-viewer
https://react.rocks/tag/Isomorphic

Cources:
react
https://ru.reactjs.org/community/courses.html



Workplan:
 - разобарться с изомрфностью или serve side rendering 
 - разработать на основе демо проект 
    * анимация
    * динамическое управление элемнами  со списками
    * переход по разделам
 - посмотреть курсы 
 - внедрить тестирование
 - storybooks
 - внедрить работу с 3d моделями
 - внедрить авторизацию
 - подключить базу данных
 >> итого проект с наметками на "магазин" с 3d проектами
 - разработать инфру под полученную архитектуру


DevOps:
 [+] простой web проект
 [-] написать terraform инфраструктуру  
 (https://github.com/awslabs/amazon-ecs-nodejs-microservices)
    - ECS
    - Instance : образ или image (https://github.com/awslabs/ami-builder-packer)

две ветки с cloudFront и без него. 
Пока пробую без CloudFront через ECS.



 Project:
  https://github.com/builderbook/builderbook
  https://reactjs.org/community/examples.html
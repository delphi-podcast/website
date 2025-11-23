---
id: 3330
title: 'WebBroker on Android and Raspberry Pi 3'
date: '2019-04-26T00:37:19-06:00'
author: 'Jim McKeeth'
layout: post
guid: 'http://delphi.org/?p=3330'
permalink: /2019/04/webbroker-on-android-and-raspberry-pi-3/
image: /wp-content/uploads/2019/04/Android-WebBroker-Server-389x198.png
categories:
    - News
tags:
    - android
    - devices
    - News
    - 'Raspberry Pi'
    - SBC
    - 'Source Code'
---

<!-- wp:image {"id":3332,"align":"right","width":273,"height":297} -->
<div class="wp-block-image"><figure class="alignright is-resized"><img src="http://delphi.org/wp-content/uploads/2019/04/Android-WebBroker-Server.png" alt="" class="wp-image-3332" width="273" height="297"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>I covered this previously in a few <a href="http://embt.co/DelphiSBC">webinars</a> and presentations, but never published the source code for WebBroker on Android. To be honest I hadn't tested it with C++Builder before, but I completely expected it to work, and it did. I also updated the tests on <a href="https://emteria.com/">Emteria.OS </a>(FKA RTAndroid) and it also works there. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The process of porting a Delphi or C++Builder WebBroker project to Android is pretty straight forward, but I'm publishing the code anyway. You create a Windows FMX WebBroker project, then copy all the code into a regular FireMonkey project. You will need to copy a few files from the RTL folder locally so you can reference them since they aren't included in the Android package.</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Web.WebReq.pas</li><li>Web.WebBroker.pas</li><li>Web.WebConst.pas</li><li>IdHTTPWebBrokerBridge.pas</li><li>IdCompilerDefines.inc</li><li>For C++Builder you also need<ul><li>Web.WebReq.hpp</li><li>Web.WebBroker.hpp</li><li>Web.WebConst.hpp</li><li>IdHTTPWebBrokerBridge.hpp</li></ul></li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>Here are the links for the Delphi and C++Builder projects. They were built and tested in with 10.3.1 Rio. I also compiled some updated details on how to build the project and how to install and test on Emteria.OS. </p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li><a href="https://github.com/jimmckeeth/DelphiAndroidWebBroker">Delphi Android WebBroker Code</a></li><li><a href="https://github.com/jimmckeeth/CppBuilderAndroidWebBroker">C++Builder Android WebBroker Code</a></li><li><a href="https://docs.google.com/presentation/d/1KHIPEebq1ZrHHEugGpzBsW56vBfevgywa6L57g91XKo/edit?usp=sharing">Guide Slide Deck</a></li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p> I mention this in the slide deck, but officially WebBroker isn't supported on Android. I tested it, and it seems to work, but if you run into an instance where it doesn't work as expected, then you are on your own. Please don't contact support and tell them I said it should work. Thanks!</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Previous <a href="https://community.idera.com/developer-tools/b/blog/posts/delphi-on-raspberry-pi">webinars</a>:</h2>
<!-- /wp:heading -->

<!-- wp:core-embed/youtube {"url":"https://youtu.be/f_Wjqin9SXU","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->
<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">
https://youtu.be/f_Wjqin9SXU
</div><figcaption>Delphi and C++Builder on Raspberry Pi and SBC<br></figcaption></figure>
<!-- /wp:core-embed/youtube -->

<!-- wp:heading {"level":3} -->
<h3><a href="https://docs.google.com/presentation/d/1bdfuji14gSpQw1RKfmKlRsH4xf_ACKvXvlUn-Tkuy2Q/edit?usp=sharing">Slides</a></h3>
<!-- /wp:heading -->

<!-- wp:html -->
<figure><iframe src="https://docs.google.com/presentation/d/e/2PACX-1vSHRjxJkCFo7XCikZ0r6ysfuBL5MGKSBBlLozcxqdTQdJrvHzWE1AOm6wlPAXvgHXAavL1UdgoYc8oy/embed?start=false&amp;loop=false&amp;delayms=3000" allowfullscreen="true" width="560" height="397"></iframe></figure>
<!-- /wp:html -->

<!-- wp:core-embed/youtube {"url":"https://youtu.be/Tm2gdBiwJ3Q","type":"video","providerNameSlug":"youtube","className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->
<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio"><div class="wp-block-embed__wrapper">
https://youtu.be/Tm2gdBiwJ3Q
</div><figcaption>Revisiting Raspberry Pi, Android and the SBC<br></figcaption></figure>
<!-- /wp:core-embed/youtube -->

<!-- wp:heading -->
<h2><a href="https://docs.google.com/presentation/d/1D2u-lA2eyYpn788Od6rBhv7HdQFyIFiaEHTU3krKvks/edit?usp=sharing">Slides</a></h2>
<!-- /wp:heading -->

<!-- wp:html -->
<figure><iframe src="https://docs.google.com/presentation/d/e/2PACX-1vQ_CsNYENs04p6-KocZuldrSgQk3B0vNswNh_E8oVTyjZnbib7ujc6SBj_zUX2PegW3eijs6NKz37Zr/embed?start=false&amp;loop=false&amp;delayms=3000" allowfullscreen="true" width="560" height="397"></iframe></figure>
<!-- /wp:html -->

<!-- wp:paragraph -->
<p><b>See also:</b> <a href="http://embt.co/DelphiChromeOS">Targeting Chrome OS with Delphi via Android and Linux </a></p>
<!-- /wp:paragraph -->
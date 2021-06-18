<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="assets/estilos.css">

    <!-- FontAwsome -->
      <script src="https://kit.fontawesome.com/0a38d3112a.js" crossorigin="anonymous"></script>

    <title>$Title$</title>
  </head>
  <body>

  <!-- Banner section -->
  <section id="banner" style="margin-top: -60px;">
      <div class="container">
          <div class="row">
              <div class="col-md-6">
                  <p class="promo-title">Viana Eats</p>
                  <p style="margin-top: 100px; font-size: 20px;">O nosso restaurante na sua mesa!</p>
              </div>
              <div class="col-md-6">
                  <img height="500" src="assets/ve-logo-40x40.png" class="img-fluid logo-img">
              </div>
          </div>
      </div>
      <img src="assets/onda.png" class="bottom-img">
  </section>



  <section>
      <h1>Nós Recomendamos</h1>
      <hr>

      <div class="container">
        <div class="container">
          <div class="row">
              <!-- cartao 1 -->
              <div class="col-md-3">
                  <div class="card" style="width: 18rem;">
                      <div class="card-body">
                          <h5 class="card-title">${joao}</h5>
                          <h6 class="card-subtitle mb-2 text-muted">xx,xx €</h6>
                          <p class="card-text" th:text="'Hello, ' + ${message} + '!'"></p>
                          <a href="#" class="card-link carrinho-icon"><i class="fas fa-shopping-cart"></i></a>
                      </div>
                  </div>
              </div>

              <!-- cartao 2 -->
              <div class="col-md-3">
                  <div class="card" style="width: 18rem;">
                      <div class="card-body">
                          <h5 class="card-title">Card title</h5>
                          <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                          <a href="#" class="card-link">Card link</a>
                          <a href="#" class="card-link">Another link</a>
                      </div>
                  </div>
              </div>

              <!-- cartao 3 -->
              <div class="col-md-3">
                  <div class="card" style="width: 18rem;">
                      <div class="card-body">
                          <h5 class="card-title">Card title</h5>
                          <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                          <a href="#" class="card-link">Card link</a>
                          <a href="#" class="card-link">Another link</a>
                      </div>
                  </div>
              </div>

              <!-- cartao 4 -->
              <div class="col-md-3">
                  <div class="card" style="width: 18rem;">
                      <div class="card-body">
                          <h5 class="card-title">Card title</h5>
                          <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                          <a href="#" class="card-link">Card link</a>
                          <a href="#" class="card-link">Another link</a>
                      </div>
                  </div>
              </div>
          </div>
        </div>
      </div>
  </section>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
  </body>
</html>

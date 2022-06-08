<!DOCTYPE HTML>
<html>
<head>
	<title>Viana Eats</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/estilos.css">

	<!-- FontAwsome -->
	<script src="https://kit.fontawesome.com/0a38d3112a.js" crossorigin="anonymous"></script>
</head>
<body>

<!--p><a href="/listC">Greet the world!</a></p-->

<!--form action="/findC/1?id=1" method="GET">
	<div>
		<p th:text="${0}"> - cenas</p>
	</div>
</form-->

<!--<p th:text = "${teste}"> test </p>-->
<!--		NavBar			  -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="index.html">Viana Eats</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarNavDropdown">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" href="#">Menu</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">Carrinho</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">Login</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">Registar</a>
			</li>
		</ul>
	</div>
</nav>

<!-- 		Banner		-->
<section id="banner" style="margin-top: -60px;">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<p class="promo-title">Viana Eats</p>
				<p style="margin-top: 100px; font-size: 20px;">O nosso restaurante na sua mesa!</p>
			</div>
			<div class="col-md-6">
				<img height="500" src="img/ve-logo-40x40.png" class="img-fluid logo-img">
			</div>
		</div>
	</div>
	<img src="img/onda.png" class="bottom-img">
</section>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>

</body>
</html>
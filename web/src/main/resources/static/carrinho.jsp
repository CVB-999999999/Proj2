<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Viana Eats - Carrinho </title>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/estilos.css">

	<!-- FontAwsome -->
	<script src="https://kit.fontawesome.com/0a38d3112a.js" crossorigin="anonymous"></script>

	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
	<script src="sweetalert2.min.js"></script>
	<link rel="stylesheet" href="sweetalert2.min.css">
	<style>
        .titulo{
            margin-top: 3%;
            margin-bottom: 3%;
            font-weight: bold;
        }
        .pesquisar-cliente{
            color: black;
        }
        .pesquisar-cliente:hover{
            color: #009900;
        }
        .center {
            margin: auto;
            width: 50%;
            border: 3px solid green;
            padding: 10px;
        }
	</style>
</head>
<body>

<!--		NavBar			  -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="index.html">Viana Eats</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarNavDropdown">
		<ul class="navbar-nav ml-auto">
			<li class="nav-item">
				<a class="nav-link" href="/menu.html">Menu</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">Carrinho</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="/login.html">Login</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="/registar.html">Registar</a>
			</li>
		</ul>
	</div>
</nav>

<section>
	<div class="titulo">
		<h1 style="text-align: center;">Carrinho de compras</h1>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-4 order-md-2 mb-4">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-muted">Carrinho</span>
					<span class="badge badge-secondary badge-pill">3</span>
				</h4>
				<ul class="list-group mb-3">
					<li class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<h6 class="my-0">Produto</h6>
							<small class="text-muted">Brief description</small>
						</div>
						<span class="text-muted">12???</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<h6 class="my-0">Second product</h6>
							<small class="text-muted">Brief description</small>
						</div>
						<span class="text-muted">8???</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<h6 class="my-0">Third item</h6>
							<small class="text-muted">Brief description</small>
						</div>
						<span class="text-muted">5???</span>
					</li>
					<li class="list-group-item d-flex justify-content-between bg-light">
						<div class="text-success">
							<h6 class="my-0">Promo code</h6>
							<small>CODIGO_DESCONTO_TOP</small>
						</div>
						<span class="text-success">-5???</span>
					</li>
					<li class="list-group-item d-flex justify-content-between">
						<span>Total (EUR)</span>
						<strong>$20</strong>
					</li>
				</ul>

				<form class="card p-2">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="C??digo de Desconto">
						<div class="input-group-append">
							<button type="submit" class="btn btn-secondary">Aplicar</button>
						</div>
					</div>
				</form>

				<button type="button" class="btn btn-light">Efetuar Login</button>
			</div>
			<div class="col-md-8 order-md-1">
				<form class="needs-validation" novalidate>
					<h4 class="mb-3">Pagamento</h4>

					<div class="d-block my-3">
						<div class="custom-control custom-radio">
							<input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked required>
							<label class="custom-control-label" for="credit">Cart??o de cr??dito</label>
						</div>
						<div class="custom-control custom-radio">
							<input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" required>
							<label class="custom-control-label" for="paypal">PayPal</label>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="cc-name">Nome do Cart??o</label>
							<input type="text" class="form-control" id="cc-name" placeholder="" required>
							<small class="text-muted">Nome do Cart??o de multibanco</small>
							<div class="invalid-feedback">
								Nome do Cart??o ?? exigido
							</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="cc-number">N??mero de cart??o</label>
							<input type="text" class="form-control" id="cc-number" placeholder="N??mero do Cart??o" required>
							<div class="invalid-feedback">
								N??mero de Cart??o ?? obrigat??rio
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-3 mb-3">
							<label for="cc-expiration">Data de Expira????o</label>
							<input type="text" class="form-control" id="cc-expiration" placeholder="Data de Expira????o" required>
							<div class="invalid-feedback">
								Data de Expira????o
							</div>
						</div>
						<div class="col-md-3 mb-3">
							<label for="cc-cvv">CVV</label>
							<input type="text" class="form-control" id="cc-cvv" placeholder="CCV" required>
							<div class="invalid-feedback">
								Codigo de Seguran??a (CCV)
							</div>
						</div>
					</div>
					<hr class="mb-4">
					<button class="btn btn-primary btn-lg btn-block center" onclick="mostraPop()">Finalizar</button>
				</form>
			</div>
		</div>
	</div>

<!-- Jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.slim.js" integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<script>
	function mostraPop() {
		Swal.fire({
			icon: 'success',
			title: 'Obrigado',
			text: 'Obrigado por adquirir a sua refi????o connosco!',
			footer: '<a href="/historicoPedido.html">Clique aqui para ser rederecionado para a pagina de acompanhamento do seu pedido.</a>'
		})
	}
</script>
</body>
</html>
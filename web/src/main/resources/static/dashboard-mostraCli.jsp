<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Viana Eats - Mostra Detalhe Cliente</title>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/estilos.css">

	<!-- FontAwsome -->
	<script src="https://kit.fontawesome.com/0a38d3112a.js" crossorigin="anonymous"></script>

	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
	<style>
        .titulo{
            margin-top: 3%;
            margin-bottom: 3%;
            font-weight: bold;
        }
        body{
            margin-top:20px;
            background:#f5f7fa;
        }
        .panel.panel-default {
            border-top-width: 3px;
        }
        .panel {
            box-shadow: 0 3px 1px -2px rgba(0,0,0,.14),0 2px 2px 0 rgba(0,0,0,.098),0 1px 5px 0 rgba(0,0,0,.084);
            border: 0;
            border-radius: 4px;
            margin-bottom: 16px;
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
		<h1 style="text-align: center;">Mostra detalhes de Cliente</h1>
	</div>

	<div class="container center">
		<div class="container bootstrap snippets bootdey">
			<div class="row ng-scope">
				<div class="col-md-8">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="h4 text-center">Informações</div>
							<div class="row pv-lg">
								<div class="col-lg-2"></div>
								<div class="col-lg-8">
									<form class="form-horizontal ng-pristine ng-valid">
										<div class="form-group">
											<label class="col-sm-2 control-label" for="inputContact1">Código de Cliente:</label>
											<div class="col-sm-10">
												<input class="form-control" id="inputContact1" type="number" placeholder="" readonly>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="inputContact1">Nome do Cliente:</label>
											<div class="col-sm-10">
												<input class="form-control" id="nome" type="text" placeholder="" readonly>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="inputContact2">Email:</label>
											<div class="col-sm-10">
												<input class="form-control" id="inputContact2" type="email" value="mail@example.com" readonly>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="inputContact3">Telemóvel</label>
											<div class="col-sm-10">
												<input class="form-control" id="inputContact3" type="text" value="(123) 465 789" readonly>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label" for="inputContact6">Address</label>
											<div class="col-sm-10">
												<textarea class="form-control" id="inputContact6" row="4" readonly>Some nice Street, 1234</textarea>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.slim.js" integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>

<!-- Data tables -->
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
</body>
</html>
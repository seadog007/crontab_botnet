<?php
if(isset($_GET['user']) && isset($_GET['deviceid'])){
	$target_path = "./uploads/".$_GET['user'].".".md5($_GET['deviceid'])."/";
	mkdir($target_path);
	$target_path = $target_path . basename( $_FILES['a']['name']);

	if(!move_uploaded_file($_FILES['a']['tmp_name'], $target_path)) {
		var_dump($_FILES);
	}
}

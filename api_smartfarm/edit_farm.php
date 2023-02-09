<?php
 include 'conn.php';
 header("Access-Control-Allow-Origin: *");

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {
        $farm_id = $_GET['farm_id']; 
        $farm_name = $_GET['farm_name']; 
        $address = $_GET['address']; 
        $tumbon = $_GET['tumbon']; 
        $amphur = $_GET['amphur']; 
        $province = $_GET['province']; 
        $email = $_GET['email']; 
        $password = $_GET['password']; 
        $typeuser = $_GET['typeuser'];
        $lat = $_GET['lat'];
        $Lng = $_GET['Lng'];
 
        $sql = "UPDATE tb_user SET farm_id = '$farm_id', farm_name = '$farm_name', address = '$address',tumbon = '$tumbon', amphur = '$amphur', province = '$province',email = '$email', password = '$password', typeuser = '$typeuser', lat = '$lat', Lng = '$Lng' WHERE farm_id = '$farm_id'";
        $result = mysqli_query($conn, $sql);
        if ($result) {
            echo "true";
        } else {
            echo "false";
        }
    } else echo "Welcome Master UNG";
}
 mysqli_close($conn);

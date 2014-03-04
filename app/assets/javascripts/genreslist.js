function GenresController($scope, $http){
	$http.get("genres.json").success(function(data, status, headers, config){
		$scope.genres = data;
	});
	$scope.order = "name";
	$scope.click = function (order){
            $scope.order = order;
            console.log(order);
        }
}
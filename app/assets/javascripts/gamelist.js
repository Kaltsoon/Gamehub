function GamesController($scope, $http){
	$http.get("games.json").success(function(data, status, headers, config){
		$scope.games = data;
	});
	$scope.order = "name";
	$scope.click = function (order){
            $scope.order = order;
            console.log(order);
        }
}
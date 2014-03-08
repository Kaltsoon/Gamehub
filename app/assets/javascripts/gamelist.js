var app = angular.module("GameApp",[]);
app.controller("GamesController", ["$scope", "$http", function($scope, $http){
	$http.get("games.json").success(function(data, status, headers, config){
		$scope.games = data;
	});
	$scope.order = "name";
	$scope.click = function (order){
        $scope.order = order;
    }
}])
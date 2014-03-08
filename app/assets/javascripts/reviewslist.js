var app = angular.module("app",[]);
app.controller("ReviewsController", ["$scope", "$http", function($scope, $http){
	$http.get("reviews.json").success(function(data, status, headers, config){
		$scope.reviews = data;
	});
	$scope.order = "game.name";
	$scope.click = function (order){
        $scope.order = order;
    }
}])

var app = angular.module("UserApp",[]);
app.controller("UsersController", ["$scope", "$http", function($scope, $http){
	$http.get("users.json").success(function(data, status, headers, config){
		$scope.users = data;
	});
	$scope.order = "username";
	$scope.click = function (order){
        $scope.order = order;
    }
}])

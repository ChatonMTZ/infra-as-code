Describe "As a infrastructure member, I want the application infrastructure to be deployed" {
    

    Context "The application database is deployed" {

        $dataResourceGroupName = "app-test-data-rg"
        $databaseSQLServerName = "app-test-sqlserver"
        $databaseName = "app-test-db"

        It "The data resource group should be created" {
            $dataResourceGroup = Get-AzureRmResourceGroup -Name $dataResourceGroupName -ErrorAction SilentlyContinue
            $dataResourceGroup | Should not be $null
        }

        It "The SQL server is created" {
            $sqlServer = Get-AzureRmSqlServer -ResourceGroupName $dataResourceGroupName -ServerName $databaseSQLServerName -ErrorAction SilentlyContinue
            $sqlServer | Should not be $null    
        }

        $database = Get-AzureRmSqlDatabase -DatabaseName $databaseName -ServerName $databaseSQLServerName -ResourceGroupName $dataResourceGroupName

        It "The database is created" {            
            $database | Should not be $null    
        }

        It "The database location is North Europe" {        
            $database.Location | Should be "North Europe"    
        }

        It "The database edition is Standard" {        
            $database.Edition | Should be "Standard"    
        }

        It "The database serivce objective name is S0" {        
            $database.CurrentServiceObjectiveName | Should be "S0"    
        }
    }

    Context "The application front server is deployed" {

        $frontResourceGroupName = "app-test-rg"
        $frontAppServicePlan = "app-test-sp"
        $frontAppServiceName = "app-test-as"

        It "The front resource group should be created" {
            $frontResourceGroup = Get-AzureRmResourceGroup -Name $frontResourceGroupName -ErrorAction SilentlyContinue
            $frontResourceGroup | Should not be $null
        }

        $frontAppServicePlan = Get-AzureRmAppServicePlan -ResourceGroupName $frontResourceGroupName -Name $frontAppServicePlan

        It "The app service plan is created" {
            $frontAppServicePlan | Should not be $null    
        }

        It "the app service plan sku tiers is Standard" {
            $frontAppServicePlan.Sku.Tier | Should be "Standard"
        }

        It "the app service plan sku Size is S1" {
            $frontAppServicePlan.Sku.Size | Should be "S1"
        }

        $frontAppService = Get-AzureRmWebApp -ResourceGroupName $frontResourceGroupName -Name $frontAppServiceName

        It "The app service is created" {
            
            $frontAppService | Should not be $null    
        }

        It "The app service location is North Europe" {
            
            $frontAppService.Location | Should be "North Europe"    
        }
    }
}
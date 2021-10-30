//Create static routes for transit vpc

resource "yandex_vpc_route_table" "transit-a" {
  folder_id = yandex_resourcemanager_folder.folder3.id
  network_id = yandex_vpc_network.vpc_name_3.id
  name = "transit-a"

  static_route {
    destination_prefix = "${replace(var.subnet-b_vpc_1, "1.0/24", "0.0/16")}"
    next_hop_address   = "${cidrhost(var.subnet-b_vpc_3, 10)}"
  }
}
//--
resource "yandex_vpc_route_table" "transit-b" {
  folder_id = yandex_resourcemanager_folder.folder3.id
  network_id = yandex_vpc_network.vpc_name_3.id
  name = "transit-b"
  static_route {
    destination_prefix = "${replace(var.subnet-a_vpc_1, "1.0/24", "0.0/16")}"
    next_hop_address   = "${cidrhost(var.subnet-a_vpc_3, 10)}"
  }
}

//Create static routes for servers vpc
resource "yandex_vpc_route_table" "servers-a" {
  folder_id = yandex_resourcemanager_folder.folder1.id
  network_id = yandex_vpc_network.vpc_name_1.id
  name = "servers-a"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "${cidrhost(var.subnet-a_vpc_1, 10)}"
  }
}

resource "yandex_vpc_route_table" "servers-b" {
  folder_id = yandex_resourcemanager_folder.folder1.id
  network_id = yandex_vpc_network.vpc_name_1.id
  name = "servers-b"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "${cidrhost(var.subnet-b_vpc_1, 10)}"
  }
}

//Create static routes for database vpc
resource "yandex_vpc_route_table" "database-a" {
  folder_id = yandex_resourcemanager_folder.folder2.id
  network_id = yandex_vpc_network.vpc_name_2.id
  name = "database-a"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "${cidrhost(var.subnet-a_vpc_2, 10)}"
  }
}

resource "yandex_vpc_route_table" "database-b" {
  folder_id = yandex_resourcemanager_folder.folder2.id
  network_id = yandex_vpc_network.vpc_name_2.id
  name = "database-b"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "${cidrhost(var.subnet-b_vpc_2, 10)}"
  }
}

//Create networks-------------------

//VPC-1
resource "yandex_vpc_network" "vpc_name_1" {
  name = var.vpc_name_1
  folder_id = yandex_resourcemanager_folder.folder1.id
}
resource "yandex_vpc_subnet" "subnet-a_vpc_1" {
  folder_id = yandex_resourcemanager_folder.folder1.id
  name           = var.subnet-a_vpc_1
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_name_1.id
  v4_cidr_blocks = [var.subnet-a_vpc_1]
  route_table_id = yandex_vpc_route_table.servers-a.id
}
resource "yandex_vpc_subnet" "subnet-b_vpc_1" {
  folder_id = yandex_resourcemanager_folder.folder1.id
  name           = var.subnet-b_vpc_1
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc_name_1.id
  v4_cidr_blocks = [var.subnet-b_vpc_1]
  route_table_id = yandex_vpc_route_table.servers-b.id
}

//VPC-2
resource "yandex_vpc_network" "vpc_name_2" {
  name = var.vpc_name_2
  folder_id = yandex_resourcemanager_folder.folder2.id
}
resource "yandex_vpc_subnet" "subnet-a_vpc_2" {
  folder_id = yandex_resourcemanager_folder.folder2.id
  name           = var.subnet-a_vpc_2
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_name_2.id
  v4_cidr_blocks = [var.subnet-a_vpc_2]
  route_table_id = yandex_vpc_route_table.database-a.id
}
resource "yandex_vpc_subnet" "subnet-b_vpc_2" {
  folder_id = yandex_resourcemanager_folder.folder2.id
  name           = var.subnet-b_vpc_2
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc_name_2.id
  v4_cidr_blocks = [var.subnet-b_vpc_2]
  route_table_id = yandex_vpc_route_table.database-b.id
}

//VPC-3
resource "yandex_vpc_network" "vpc_name_3" {
  name = var.vpc_name_3
  folder_id = yandex_resourcemanager_folder.folder3.id
}
resource "yandex_vpc_subnet" "subnet-a_vpc_3" {
  folder_id = yandex_resourcemanager_folder.folder3.id
  name           = var.subnet-a_vpc_3
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_name_3.id
  v4_cidr_blocks = [var.subnet-a_vpc_3]
  route_table_id = yandex_vpc_route_table.transit-a.id
}
resource "yandex_vpc_subnet" "subnet-b_vpc_3" {
  folder_id = yandex_resourcemanager_folder.folder3.id
  name           = var.subnet-b_vpc_3
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc_name_3.id
  v4_cidr_blocks = [var.subnet-b_vpc_3]
  route_table_id = yandex_vpc_route_table.transit-b.id
}

//VPC-4
resource "yandex_vpc_network" "vpc_name_4" {
  name = var.vpc_name_4
  folder_id = yandex_resourcemanager_folder.folder4.id
}
resource "yandex_vpc_subnet" "subnet-a_vpc_4" {
  folder_id = yandex_resourcemanager_folder.folder4.id
  name           = var.subnet-a_vpc_4
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_name_4.id
  v4_cidr_blocks = [var.subnet-a_vpc_4]
}
resource "yandex_vpc_subnet" "subnet-b_vpc_4" {
  folder_id = yandex_resourcemanager_folder.folder4.id
  name           = var.subnet-b_vpc_4
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc_name_4.id
  v4_cidr_blocks = [var.subnet-b_vpc_4]
}

//VPC-5
resource "yandex_vpc_network" "vpc_name_5" {
  name = var.vpc_name_5
  folder_id = yandex_resourcemanager_folder.folder5.id
}
resource "yandex_vpc_subnet" "subnet-a_vpc_5" {
  folder_id = yandex_resourcemanager_folder.folder5.id
  name           = var.subnet-a_vpc_5
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_name_5.id
  v4_cidr_blocks = [var.subnet-a_vpc_5]
}
resource "yandex_vpc_subnet" "subnet-b_vpc_5" {
  folder_id = yandex_resourcemanager_folder.folder5.id
  name           = var.subnet-b_vpc_5
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc_name_5.id
  v4_cidr_blocks = [var.subnet-b_vpc_5]
}

//VPC-6
resource "yandex_vpc_network" "vpc_name_6" {
  name = var.vpc_name_6
  folder_id = yandex_resourcemanager_folder.folder6.id
}
resource "yandex_vpc_subnet" "subnet-a_vpc_6" {
  folder_id = yandex_resourcemanager_folder.folder6.id
  name           = var.subnet-a_vpc_6
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_name_6.id
  v4_cidr_blocks = [var.subnet-a_vpc_6]
}
resource "yandex_vpc_subnet" "subnet-b_vpc_6" {
  folder_id = yandex_resourcemanager_folder.folder6.id
  name           = var.subnet-b_vpc_6
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc_name_6.id
  v4_cidr_blocks = [var.subnet-b_vpc_6]
}

//VPC-7
resource "yandex_vpc_network" "vpc_name_7" {
  name = var.vpc_name_7
  folder_id = yandex_resourcemanager_folder.folder7.id
}
resource "yandex_vpc_subnet" "subnet-a_vpc_7" {
  folder_id = yandex_resourcemanager_folder.folder7.id
  name           = var.subnet-a_vpc_7
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_name_7.id
  v4_cidr_blocks = [var.subnet-a_vpc_7]
}
resource "yandex_vpc_subnet" "subnet-b_vpc_7" {
  folder_id = yandex_resourcemanager_folder.folder7.id
  name           = var.subnet-b_vpc_7
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc_name_7.id
  v4_cidr_blocks = [var.subnet-b_vpc_7]
}

//VPC-8
resource "yandex_vpc_network" "vpc_name_8" {
  name = var.vpc_name_8
  folder_id = yandex_resourcemanager_folder.folder8.id
}
resource "yandex_vpc_subnet" "subnet-a_vpc_8" {
  folder_id = yandex_resourcemanager_folder.folder8.id
  name           = var.subnet-a_vpc_8
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc_name_8.id
  v4_cidr_blocks = [var.subnet-a_vpc_8]
}
resource "yandex_vpc_subnet" "subnet-b_vpc_8" {
  folder_id = yandex_resourcemanager_folder.folder8.id
  name           = var.subnet-b_vpc_8
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.vpc_name_8.id
  v4_cidr_blocks = [var.subnet-b_vpc_8]
}
# [START vertex_ai_enable_api]
resource "google_project_service" "aiplatform" {
  provider           = google-beta
  service            = "aiplatform.googleapis.com"
  disable_on_destroy = false
}
# [END vertex_ai_enable_api]

# [START vertex_ai_managed_notebooks_runtime_basic]
resource "google_notebooks_runtime" "basic_runtime" {
  name     = "notebooks-runtime-basic"
  location = "us-central1"

  access_config {
    access_type   = "SINGLE_USER"
    runtime_owner = "admin@hashicorptest.com"
  }

  virtual_machine {
    virtual_machine_config {
      machine_type = "n1-standard-4"
      data_disk {
        initialize_params {
          disk_size_gb = "100"
          disk_type    = "PD_STANDARD"
        }
      }
    }
  }

  depends_on = [google_project_service.aiplatform]
}
# [END vertex_ai_managed_notebooks_runtime_basic]

# [START vertex_ai_managed_notebooks_runtime_gpu]
resource "google_notebooks_runtime" "gpu_runtime" {
  name     = "notebooks-runtime-gpu"
  location = "us-central1"

  access_config {
    access_type   = "SINGLE_USER"
    runtime_owner = "admin@hashicorptest.com"
  }

  software_config {
    install_gpu_driver = true
  }

  virtual_machine {
    virtual_machine_config {
      machine_type = "n1-standard-4"
      data_disk {
        initialize_params {
          disk_size_gb = "100"
          disk_type    = "PD_STANDARD"
        }
      }
      accelerator_config {
        core_count = "1"
        type       = "NVIDIA_TESLA_V100"
      }
    }
  }
}
# [END vertex_ai_managed_notebooks_runtime_gpu]

# [START vertex_ai_managed_notebooks_runtime_container]
resource "google_notebooks_runtime" "container_runtime" {
  name     = "notebooks-runtime-container"
  location = "us-central1"

  access_config {
    access_type   = "SINGLE_USER"
    runtime_owner = "admin@hashicorptest.com"
  }

  virtual_machine {
    virtual_machine_config {
      machine_type = "n1-standard-4"
      data_disk {
        initialize_params {
          disk_size_gb = "100"
          disk_type    = "PD_STANDARD"
        }
      }
      container_images {
        repository = "gcr.io/deeplearning-platform-release/base-cpu"
        tag        = "latest"
      }
      container_images {
        repository = "gcr.io/deeplearning-platform-release/beam-notebooks"
        tag        = "latest"
      }
    }
  }
}
# [END vertex_ai_managed_notebooks_runtime_container]

# [START vertex_ai_managed_notebooks_runtime_kernel]
resource "google_notebooks_runtime" "kernel_runtime" {
  name     = "notebooks-runtime-kernel"
  location = "us-central1"

  access_config {
    access_type   = "SINGLE_USER"
    runtime_owner = "admin@hashicorptest.com"
  }
  
  software_config {
    kernels {
      repository = "gcr.io/deeplearning-platform-release/base-cpu"
      tag        = "latest"
    }
  }

  virtual_machine {
    virtual_machine_config {
      machine_type = "n1-standard-4"
      data_disk {
        initialize_params {
          disk_size_gb = "100"
          disk_type    = "PD_STANDARD"
        }
      }
    }
  }
}
# [START vertex_ai_managed_notebooks_runtime_kernel]

# [START vertex_ai_managed_notebooks_runtime_script]
resource "google_notebooks_runtime" "script_runtime" {
  name     = "notebooks-runtime-script"
  location = "us-central1"

  access_config {
    access_type   = "SINGLE_USER"
    runtime_owner = "admin@hashicorptest.com"
  }

  software_config {
    post_startup_script_behavior = "RUN_EVERY_START"
  }

  virtual_machine {
    virtual_machine_config {
      machine_type = "n1-standard-4"
      data_disk {
        initialize_params {
          disk_size_gb = "100"
          disk_type    = "PD_STANDARD"
        }
      }
    }
  }
}
# [START vertex_ai_managed_notebooks_runtime_script]


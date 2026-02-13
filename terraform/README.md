# Zitadel Terraform Configuration

This directory contains the Terraform configuration to manage the Zitadel state for the **Tuxmai RAG** project.

## Prerequisites

1.  **Zitadel Instance**: You must have Zitadel running.
2.  **Service User Key**: Terraform needs a "Service User" to authenticate with the Zitadel API.

### How to get the Service User Key

Since you are setting this up for the first time:

1.  Log in to your Zitadel Console (e.g., `https://login.tuxmart.io` or `http://localhost:8080/ui/console`) using your Super Admin credentials (`admin@tuxmart.io` / `SuperSecret123!` or whatever you configured in `values.yaml`).
2.  Go to **Organization** -> **Service Users**.
3.  Click **New**.
4.  Username: `terraform`. Name: `Terraform Automation`.
5.  **Important**: Grant this user the role **Org Owner** (or IAM Owner if managing system-wide). For this setup, **Org Owner** is sufficient.
6.  Click **Create**.
7.  Click on the newly created user `terraform`.
8.  Go to **Keys** -> **New** -> **Type: JSON** -> **Add**.
9.  A file will download. **Save this file** as `terraform-key.json` inside this `terraform/` directory.

## Usage

1.  **Initialize Terraform**:
    ```bash
    terraform init
    ```

2.  **Review the Plan**:
    ```bash
    terraform plan
    ```
    This will show you the resources it intends to create (Project `tuxmai-rag`, Roles, Apps).

3.  **Apply the Configuration**:
    ```bash
    terraform apply
    ```
    Type `yes` when prompted.

4.  **Get your IDs**:
    After a successful apply, Terraform will output the new IDs:
    ```bash
    Outputs:
    frontend_client_id = "..."
    api_client_id = "..."
    ```

## Post-Setup

Update your application `env` files with these new IDs.

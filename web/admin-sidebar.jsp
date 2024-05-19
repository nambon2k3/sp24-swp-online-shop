
<!-- Custom CSS -->
<style>
    /* Sidebar style */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        width: 11%;
        background-color: #343a40;
        padding-top: 56px;
        z-index: 1;
        transition: width 0.3s;
    }

    .sidebar ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .sidebar li {
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .sidebar a {
        color: #f8f9fa;
        text-decoration: none;
    }

    .sidebar a:hover {
        color: #007bff;
    }

    /* Main content style */
    .main-content {
        padding-left: 11%;
    }
</style>

<!-- Sidebar -->
<nav class="sidebar">
    <ul>
        <li><a href="dashboard"><i class="fas fa-tachometer-alt mr-2"></i>Dashboard</a></li>
        <li><a href="user"><i class="fas fa-users mr-2"></i>Customers</a></li>
        <li><a href="setting"><i class="fas fa-cog mr-2"></i>Settings</a></li>
    </ul>
</nav>

import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Equipment from '../views/equipments/EquipmentHome.vue';
import AddEquipment from '../views/equipments/AddEquipment.vue';
import EditEquipment from '../views/equipments/EditEquipment.vue';
import MaintenanceTask from '../views/tasks/MaintenanceTaskHome.vue';
import AddMaintenanceTask from '../views/tasks/AddMaintenanceTask.vue';
import EditMaintenanceTask from '../views/tasks/EditMaintenanceTask.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/equipments', component: Equipment },
  { path: '/equipments/add', component: AddEquipment },
  { path: '/equipments/:id', component: EditEquipment },
  { path: '/tasks', component: MaintenanceTask },
  { path: '/tasks/add', component: AddMaintenanceTask },
  { path: '/tasks/:id', component: EditMaintenanceTask }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
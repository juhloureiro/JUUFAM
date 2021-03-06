<?php
/* @var $this InstitutoController */
/* @var $model Instituto */

$this->breadcrumbs=array(
	'Institutos'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'Listar Institutos', 'url'=>array('index')),
	array('label'=>'Criar Instituto', 'url'=>array('create')),
	array('label'=>'Editar Instituto', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Deletar Instituto', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Gerenciar Institutos', 'url'=>array('admin')),
);
?>

<h1>View Instituto #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nome',
		'id_uni',
	),
)); ?>

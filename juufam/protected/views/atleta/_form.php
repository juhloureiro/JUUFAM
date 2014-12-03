<?php
/* @var $this AtletaController */
/* @var $model Atleta */
/* @var $form CActiveForm */
?>

<div class="form">

<!-- import javascript -->
<?php

$baseUrl = Yii::app ()->baseUrl;
$cs = Yii::app ()->getClientScript ();
$cs->registerScriptFile ( $baseUrl . '/js/jquery-1.11.1.min.js' );
$cs->registerScriptFile ( $baseUrl . '/js/jquery.maskedinput.js' );
?>

<?php

$form = $this->beginWidget ( 'CActiveForm', array (
		'id' => 'atleta-form',
		
		// Please note: When you enable ajax validation, make sure the corresponding
		// controller action is handling ajax validation correctly.
		// There is a call to performAjaxValidation() commented in generated controller code.
		// See class documentation of CActiveForm for details on this.
		'enableAjaxValidation' => false 
) );
?>

	<p class="note">
		Campos com <span class="required">*</span> são obrigatórios.
	</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'matricula'); ?>
		<?php echo $form->textField($model,'matricula',array('size'=>8,'maxlength'=>8)); ?>
		<?php echo $form->error($model,'matricula'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'cpf'); ?>
		<?php echo $form->textField($model,'cpf',array('size'=>11,'maxlength'=>11)); ?>
		<?php echo $form->error($model,'cpf'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'rg'); ?>
		<?php echo $form->textField($model,'rg',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'rg'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'nome'); ?>
		<?php echo $form->textField($model,'nome',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'nome'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'data_nasc'); ?>
		<?php echo $form->textField($model,'data_nasc',array('size'=>45,'maxlength'=>45,'id'=>'dataNasc')); ?>
		<?php echo $form->error($model,'data_nasc'); ?>
	</div>

	<script type="text/javascript">
		jQuery(function($){
	   	$("#dataNasc").mask("99/99/9999",{placeholder:"dd/mm/yyyy"});
		});
	</script>

	<div class="row">
		<label for="Atleta_genero" class="required"> Genero <span
			class="required">*</span>
		</label> <br /> <select name="Atleta[genero]">
			<option value="masculino">Masculino</option>
			<option value="feminino">Feminino</option>
		</select>
		<?php echo $form->error($model,'genero'); ?>
	</div>

	<div class="row">
		<label for="Atleta_tipo_atleta" class="required"> Tipo de Atleta <span
			class="required">*</span>
		</label> <br /> <select name="Atleta[tipo_atleta]">
			<option value="ativo">Ativo</option>
			<option value="funcionario">Funcionario</option>
			<option value="egresso">Egresso</option>
		</select>
		<?php echo $form->error($model,'tipo_atleta'); ?>
	</div>

	<?php
	$controller = new CursoController ( 'chapa' );
	$models = $controller->getAllCursos();
	
	/* Lista as chapas para serem vinculadas ao novo representante */
	
	if (sizeof ( $models ) > 0) {
		echo '<div class="row">';
		echo '<label  class="required"> Curso do Atleta <span class="required">*</span></label>';
		print '<select name="Atleta[id_curso]">';
		foreach ( $models as $model ) {
			print '<option  value="' . $model->id . '"> ' . $model->nome . '</option>';
		}
		print '</select>';
		echo $form->error($model,'id_curso');
		echo '</div>';
		
		echo '<div class="row buttons">';
		
		echo CHtml::submitButton ( $model->isNewRecord ? 'Create' : 'Save' );
		
		echo '</div>';
	} else {
		echo '<div class="row">';
		print "<h4>Não existe nenhum curso cadastrado , por favor crie um para que você possa prosseguir</h4>";
		echo '</div>';
	}
	
	?>

<?php $this->endWidget(); ?>

</div>
<!-- form -->

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import weka.classifiers.trees.ADTree;
import weka.classifiers.trees.BFTree;
import weka.classifiers.trees.DecisionStump;
import weka.classifiers.trees.LADTree;
import weka.classifiers.trees.SimpleCart;
import weka.classifiers.functions.VotedPerceptron;
import weka.classifiers.functions.MultilayerPerceptron;

import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.CSVLoader;
import weka.core.converters.CSVSaver;

public class BrainoRead {

	CSVLoader trainLoader;
	Instances trainDataset;

	CSVLoader probLoader;
	Instances prob;

	CSVLoader testLoader;
	Instances testDataset;

	public static void main(String[] args) {
		System.out.println("Something");
		//trainAndTest("ADTree",true, false);

	}
	int aDTree(boolean train, boolean test){
		try{
			ADTree model;
			if(!test){
				model = new ADTree();
				model.buildClassifier(trainDataset);
			}else{
				ObjectInputStream f = new ObjectInputStream(new FileInputStream("currentModel.obj"));
				model = (ADTree)f.readObject();
				f.close();
			}
			
			
			if(!train){
				int num = testDataset.numInstances();
				for(int i = 0; i < num; i++){
					Instance newInst = testDataset.instance(i);
					double p = model.classifyInstance(newInst);
					prob.instance(i).setValue(1, p);
				}
				
				CSVSaver saver = new CSVSaver();
				saver.setInstances(prob);
				saver.setFile(new File("result_prob.csv"));
				saver.writeBatch();
			}else{
				ObjectOutputStream f = new ObjectOutputStream(new FileOutputStream(new File("currentModel.obj")));
				f.writeObject(model);
				f.close();
			}

		}catch(Exception e){
			System.out.println("Error from Java : "+e.getMessage());
			return 0;
		}
		return 1;
	}
	int bFTree(boolean train, boolean test){
		try{
			BFTree model;
			if(!test){
				model = new BFTree();
				model.buildClassifier(trainDataset);
			}else{
				ObjectInputStream f = new ObjectInputStream(new FileInputStream("currentModel.obj"));
				model = (BFTree)f.readObject();
				f.close();
			}
			
			//System.out.println("ADTree...done");
			if(!train){
				int num = testDataset.numInstances();
				for(int i = 0; i < num; i++){
					Instance newInst = testDataset.instance(i);
					double p = model.classifyInstance(newInst);
					prob.instance(i).setValue(1, p);
				}
				
				CSVSaver saver = new CSVSaver();
				saver.setInstances(prob);
				saver.setFile(new File("result_prob.csv"));
				saver.writeBatch();
			}else{
				ObjectOutputStream f = new ObjectOutputStream(new FileOutputStream(new File("currentModel.obj")));
				f.writeObject(model);
				f.close();
			}
			
		}catch(Exception e){
			System.out.println("Error from Java : "+e.getMessage());
			return 0;
		}
		return 1;
	}
	int decisionStump(boolean train, boolean test){
		try{
			DecisionStump model;
			if(!test){
				model = new DecisionStump();
				model.buildClassifier(trainDataset);
			}else{
				ObjectInputStream f = new ObjectInputStream(new FileInputStream("currentModel.obj"));
				model = (DecisionStump)f.readObject();
				f.close();
			}
			
			//System.out.println("ADTree...done");
			if(!train){
				int num = testDataset.numInstances();
				for(int i = 0; i < num; i++){
					Instance newInst = testDataset.instance(i);
					double p = model.classifyInstance(newInst);
					prob.instance(i).setValue(1, p);
				}
				
				CSVSaver saver = new CSVSaver();
				saver.setInstances(prob);
				saver.setFile(new File("result_prob.csv"));
				saver.writeBatch();
			}else{
				ObjectOutputStream f = new ObjectOutputStream(new FileOutputStream(new File("currentModel.obj")));
				f.writeObject(model);
				f.close();
			}
		}catch(Exception e){
			System.out.println("Error from Java : "+e.getMessage());
			return 0;
		}
		return 1;
	}
	int lADTree(boolean train, boolean test){
		try{
			LADTree model;
			if(!test){
				model = new LADTree();
				model.buildClassifier(trainDataset);
			}else{
				ObjectInputStream f = new ObjectInputStream(new FileInputStream("currentModel.obj"));
				model = (LADTree)f.readObject();
				f.close();
			}
			
			//System.out.println("ADTree...done");
			if(!train){
				int num = testDataset.numInstances();
				for(int i = 0; i < num; i++){
					Instance newInst = testDataset.instance(i);
					double p = model.classifyInstance(newInst);
					prob.instance(i).setValue(1, p);
				}
				
				CSVSaver saver = new CSVSaver();
				saver.setInstances(prob);
				saver.setFile(new File("result_prob.csv"));
				saver.writeBatch();
			}else{
				ObjectOutputStream f = new ObjectOutputStream(new FileOutputStream(new File("currentModel.obj")));
				f.writeObject(model);
				f.close();
			}
		}catch(Exception e){
			System.out.println("Error from Java : "+e.getMessage());
			return 0;
		}
		return 1;
	}
	int simpleCart(boolean train, boolean test){
		try{
			SimpleCart model;
			if(!test){
				model = new SimpleCart();
				model.buildClassifier(trainDataset);
			}else{
				ObjectInputStream f = new ObjectInputStream(new FileInputStream("currentModel.obj"));
				model = (SimpleCart)f.readObject();
				f.close();
			}
			
			//System.out.println("ADTree...done");
			if(!train){
				int num = testDataset.numInstances();
				for(int i = 0; i < num; i++){
					Instance newInst = testDataset.instance(i);
					double p = model.classifyInstance(newInst);
					prob.instance(i).setValue(1, p);
				}
				
				CSVSaver saver = new CSVSaver();
				saver.setInstances(prob);
				saver.setFile(new File("result_prob.csv"));
				saver.writeBatch();
			}else{
				ObjectOutputStream f = new ObjectOutputStream(new FileOutputStream(new File("currentModel.obj")));
				f.writeObject(model);
				f.close();
			}
		}catch(Exception e){
			System.out.println("Error from Java : "+e.getMessage());
			return 0;
		}
		return 1;
	}
	int votedPerceptron(boolean train, boolean test){
		try{
			VotedPerceptron model;
			if(!test){
				model = new VotedPerceptron();
				model.buildClassifier(trainDataset);
			}else{
				ObjectInputStream f = new ObjectInputStream(new FileInputStream("currentModel.obj"));
				model = (VotedPerceptron)f.readObject();
				f.close();
			}
			
			//System.out.println("ADTree...done");
			if(!train){
				int num = testDataset.numInstances();
				for(int i = 0; i < num; i++){
					Instance newInst = testDataset.instance(i);
					double p = model.classifyInstance(newInst);
					prob.instance(i).setValue(1, p);
				}
				
				CSVSaver saver = new CSVSaver();
				saver.setInstances(prob);
				saver.setFile(new File("result_prob.csv"));
				saver.writeBatch();
			}else{
				ObjectOutputStream f = new ObjectOutputStream(new FileOutputStream(new File("currentModel.obj")));
				f.writeObject(model);
				f.close();
			}
		}catch(Exception e){
			System.out.println("Error from Java : "+e.getMessage());
			return 0;
		}
		return 1;
	}
	int multilayerPerceptron(boolean train, boolean test){
		try{
			MultilayerPerceptron model;
			if(!test){
				model = new MultilayerPerceptron();
				model.buildClassifier(trainDataset);
			}else{
				ObjectInputStream f = new ObjectInputStream(new FileInputStream("currentModel.obj"));
				model = (MultilayerPerceptron)f.readObject();
				f.close();
			}
			
			//System.out.println("ADTree...done");
			if(!train){
				int num = testDataset.numInstances();
				for(int i = 0; i < num; i++){
					Instance newInst = testDataset.instance(i);
					double p = model.classifyInstance(newInst);
					prob.instance(i).setValue(1, p);
				}
				
				CSVSaver saver = new CSVSaver();
				saver.setInstances(prob);
				saver.setFile(new File("result_prob.csv"));
				saver.writeBatch();
			}else{
				ObjectOutputStream f = new ObjectOutputStream(new FileOutputStream(new File("currentModel.obj")));
				f.writeObject(model);
				f.close();
			}
		}catch(Exception e){
			System.out.println("Error from Java : "+e.getMessage());
			return 0;
		}
		return 1;
	}
	public int trainAndTest(String method, boolean train, boolean test){
		try{
			if(!train && !test){
				trainLoader = new CSVLoader();
				trainLoader.setSource(new File("train.csv"));
				trainDataset = trainLoader.getDataSet();
				trainDataset.setClassIndex(0);

				probLoader = new CSVLoader();
				probLoader.setSource(new File("result.csv"));
				prob = probLoader.getDataSet();

				testLoader = new CSVLoader();
				testLoader.setSource(new File("test.csv"));
				testDataset = testLoader.getDataSet();
				testDataset.setClassIndex(0);
			}
			if(train){
				trainLoader = new CSVLoader();
				trainLoader.setSource(new File("train.csv"));
				trainDataset = trainLoader.getDataSet();
				trainDataset.setClassIndex(0);
			}
			if(test){
				probLoader = new CSVLoader();
				probLoader.setSource(new File("result.csv"));
				prob = probLoader.getDataSet();
				
				testLoader = new CSVLoader();
				testLoader.setSource(new File("test.csv"));
				testDataset = testLoader.getDataSet();
				testDataset.setClassIndex(0);
			}


		}catch(IOException e){
			try{
				FileOutputStream f = new FileOutputStream(new File("logs.txt"));
				byte msg[] = e.getMessage().getBytes();
				for(int i = 0; i < msg.length; i++){
					f.write(msg[i]);
				}
				f.close();
			}catch(IOException e1){
				
			}
			System.out.println("Error from Java : "+e.getMessage());
			return 0;
		}
		switch(method){
		case "ADTree":
			return aDTree(train, test);
			
		case "BFTree":
			return bFTree(train, test);
			
		case "DecisionStump":
			return decisionStump(train, test);
			
		case "LADTree":
			return lADTree(train, test);
			
		case "SimpleCart":
			return simpleCart(train, test);
			
		case "VotedPerceptron":
			return votedPerceptron(train, test);
			
		case "MultilayerPerceptron":
			return multilayerPerceptron(train, test);
			
		default:
			return 0;
		}
	}
}

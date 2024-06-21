
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';


class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller=TextEditingController();

  callGeminiModel()async
  {
    try
    {
      if(_controller.text.isNotEmpty)
      {
        setState(() {
           _messages.add(Message(text: _controller.text, isUser: true));
            _controller.clear();
        });
       
      }
     final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: "AIzaSyDlnKV63746NzSSwXTeYo6ipjXALbjWKto" ,generationConfig: GenerationConfig(maxOutputTokens: 100));
    
    final List<Content> history = _messages.map((msg) => Content.text(msg.text)) .toList();
        final chat = model.startChat(history: history);
     final prompt=_messages.last.text;
     final  content = Content.text(prompt);
     final response = await chat.sendMessage(content);
     setState(() {
       _messages.add(Message(text: response.text!, isUser: false));
     });
    
    }
    catch(e){
      print('eroor: $e');
    }
  }
 final List <Message> _messages=
  [
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(shadowColor: Colors.grey[300],elevation: 0.4,
        centerTitle: false,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Image.asset(ImageAsset.robot5Image ,height:45,width:45,),
             SizedBox(width: 10,),
             Text('Gemini', style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index)
              {
                print(_messages[index].text);
                final message=_messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.isUser ? Alignment.centerRight :Alignment.centerLeft ,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message.isUser? AppColor.primaryColor : Colors.grey[300],
                        borderRadius: message.isUser?
                        const BorderRadius.only(
                          topLeft:  Radius.circular(20), 
                          bottomLeft:Radius.circular(20),
                          bottomRight: Radius.circular(20) )
                        :const BorderRadius.only(
                          topRight:  Radius.circular(20), 
                          bottomLeft:Radius.circular(20),
                          bottomRight: Radius.circular(20) ) ),
                        
                      child: Text(message.text , 
                      style: TextStyle(color: message.isUser? Colors.white : Colors.black),)),
                  ),
                );
              }),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25 , horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor ), borderRadius: BorderRadius.circular(20) ),
              focusColor: AppColor.primaryColor,
              floatingLabelBehavior:FloatingLabelBehavior.always ,
                      hintText: 'Write a meesage',
                     
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      
                    ),
                  ),
                ),
                IconButton(onPressed: callGeminiModel, 
                icon:const Icon( Icons.send_outlined , color: AppColor.primaryColor,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class Message{
  final String text;
  final bool isUser;
  Message({required this.text,required this.isUser, });
}